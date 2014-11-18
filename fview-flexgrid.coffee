View = famous.core.View
Entity = famous.core.Entity
Modifier = famous.core.Modifier
Transform = famous.core.Transform
Transitionable = famous.transitions.Transitionable
TransitionableTransform = famous.transitions.TransitionableTransform
Easing = famous.transitions.Easing

class FlexGrid extends View
  DEFAULT_OPTIONS:
    marginTop: undefined
    marginSide: undefined
    gutterCol: undefined
    gutterRow: undefined
    itemSize: undefined
    transition:
      duration: 500
      curve: Easing.outBack

  constructor: (@options)->
    @constructor.DEFAULT_OPTIONS = @DEFAULT_OPTIONS
    super @options
    @_modifiers = []
    @_states = []
    @_height = 0
    @id = Entity.register @

  _calcSpacing: (width) ->
    itemWidth = @options.itemSize[0]
    gutterCol = @options.gutterCol
    ySpacing = itemWidth + gutterCol
    margin = @options.marginSide
    numCols = Math.floor (width - 2 * margin + gutterCol) / ySpacing
    margin = (width - numCols * ySpacing + gutterCol) / 2
    {
      numCols: numCols
      marginSide: margin
      ySpacing: ySpacing
    }

  _calcPositions: (spacing) ->
    positions = []
    col = row = 0
    for item in @_items
      xPos = spacing.marginSide + col * spacing.ySpacing
      yPos = @options.marginTop + row * (@options.itemSize[1] + @options.gutterRow)
      positions.push [xPos, yPos, 0]
      col++
      if col is spacing.numCols
        row++;
        col = 0
    @_height = yPos + @options.itemSize[1] + @options.marginTop
    positions

  _createModifier: (index, position, size) ->
    transitionItem = {
      transform: (new TransitionableTransform(Transform.translate.apply(null, position)))
    , size: (new Transitionable(size or @options.itemSize))
    }

    modifier = new Modifier transitionItem
    @_states[index] = transitionItem
    @_modifiers[index] = modifier

  _animateModifier: (index, position, size) ->
    transformTransitionable = @_states[index].transform
    sizeTransitionable = @_states[index].size
    transformTransitionable.halt()
    sizeTransitionable.halt()
    transformTransitionable.setTranslate position, @options.transition
    sizeTransitionable.set size, @options.transition

  sequenceFrom: (items) -> @_items = items

  render: -> @id

  getSize: ->
    unless this._height
      return
    [@_cachedWidth, @_height]

  commit: (context) ->
    width = context.size[0]
    specs = []
    unless @_cachedWidth is width
      spacing = @_calcSpacing width
      size = @options.itemSize
      if spacing.numCols < 2
        spacing.numCols = 1
        spacing.marginSide = 0
        size = [width, size[1]]
      positions = @_calcPositions spacing
      for i in [0...@_items.length]
        if @_modifiers[i] is undefined
          @_createModifier i, positions[i], size
        else
          @_animateModifier i, positions[i], size
      @_cachedWidth = width
    for i in [0...this._modifiers.length]
      spec = @_modifiers[i].modify target: @_items[i].render()
      specs.push spec
    specs
