FView.ready(function(){
  var Entity = require('famous/core/Entity');
  var RenderNode = require('famous/core/RenderNode');
  var Transform = require('famous/core/Transform');
  var ViewSequence = require('famous/core/ViewSequence');
  var EventHandler = require('famous/core/EventHandler');
  var Modifier = require('famous/core/Modifier');
  var OptionsManager = require('famous/core/OptionsManager');
  var Transitionable = require('famous/transitions/Transitionable');
  var TransitionableTransform = require('famous/transitions/TransitionableTransform');

  function MyGridLayout(options) {
    this.options = Object.create(MyGridLayout.DEFAULT_OPTIONS);
    this.optionsManager = new OptionsManager(this.options);
    if (options) this.setOptions(options);
    console.log('options', this.options);

    this.id = Entity.register(this);

    this._modifiers = [];
    this._states = [];
    this._contextSizeCache = [0, 0];
    this._dimensionsCache = [0, 0];
    this._activeCount = 0;

    this._eventOutput = new EventHandler();
    EventHandler.setOutputHandler(this, this._eventOutput);
  }

  function _reflow(size, cols, rows) {
    var usableSize = [size[0], size[1]];
    usableSize[0] -= this.options.gutterSize[0] * (cols - 1);
    usableSize[1] -= this.options.gutterSize[1] * (rows - 1);

    var rowSize = Math.round(usableSize[1] / rows);
    var colSize = Math.round(usableSize[0] / cols);

    var currY = 0;
    var currX;
    var currIndex = 0;
    for (var i = 0; i < rows; i++) {
      currX = 0;
      for (var j = 0; j < cols; j++) {
        if (this._modifiers[currIndex] === undefined) {
          _createModifier.call(this, currIndex, [colSize, rowSize], [currX, currY, 0], 1);
        }
        else {
          _animateModifier.call(this, currIndex, [colSize, rowSize], [currX, currY, 0], 1);
        }

        currIndex++;
        currX += colSize + this.options.gutterSize[0];
      }

      currY += rowSize + this.options.gutterSize[1];
    }

    this._dimensionsCache = [this.options.dimensions[0], this.options.dimensions[1]];
    this._contextSizeCache = [size[0], size[1]];

    this._activeCount = rows * cols;

    for (i = this._activeCount ; i < this._modifiers.length; i++) _animateModifier.call(this, i, [Math.round(colSize), Math.round(rowSize)], [0, 0], 0);

    this._eventOutput.emit('reflow');
  }

  function _createModifier(index, size, position, opacity) {
    var transitionItem = {
      transform: new TransitionableTransform(Transform.translate.apply(null, position)),
      opacity: new Transitionable(opacity),
      size: new Transitionable(size)
    };

    var modifier = new Modifier({
      transform: transitionItem.transform,
      opacity: transitionItem.opacity,
      size: transitionItem.size
    });

    this._states[index] = transitionItem;
    this._modifiers[index] = modifier;

  }

  function _animateModifier(index, size, position, opacity) {
    var currState = this._states[index];

    var currSize = currState.size;
    var currOpacity = currState.opacity;
    var currTransform = currState.transform;

    var transition = this.options.transition;

    currTransform.halt();
    currOpacity.halt();
    currSize.halt();

    currTransform.setTranslate(position, transition);
    currSize.set(size, transition);
    currOpacity.set(opacity, transition);
  }

  MyGridLayout.DEFAULT_OPTIONS = {
    dimensions: [1, 1],
    transition: false,
    gutterSize: [0, 0]
  };

  /**
  * Generate a render spec from the contents of this component.
  *
  * @private
  * @method render
  * @return {Object} Render spec for this component
  */
  MyGridLayout.prototype.render = function render() {
    //console.log('render', this._sequence);
    return this.id;
  };

  /**
  * Patches the MyGridLayout instance's options with the passed-in ones.
  *
  * @method setOptions
  * @param {Options} options An object of configurable options for the MyGridLayout instance.
  */
  MyGridLayout.prototype.setOptions = function setOptions(options) {
    console.log('setOptions', this._sequence, options);
    return this.optionsManager.setOptions(options);
  };

  /**
  * Sets the collection of renderables under the MyGridLayout instance's control.
  *
  * @method sequenceFrom
  * @param {Array|ViewSequence} sequence Either an array of renderables or a Famous viewSequence.
  */
  MyGridLayout.prototype.sequenceFrom = function sequenceFrom(sequence) {
    console.log('sequenceFrom', sequence);
    if (sequence instanceof Array) sequence = new ViewSequence(sequence);
    this.sequence = sequence;
  };

  /**
  * Returns the size of the grid layout.
  *
  * @method getSize
  * @return {Array} Total size of the grid layout.
  */
  MyGridLayout.prototype.getSize = function getSize() {
    return this._contextSizeCache;
  };

  /**
  * Apply changes from this component to the corresponding document element.
  * This includes changes to classes, styles, size, content, opacity, origin,
  * and matrix transforms.
  *
  * @private
  * @method commit
  * @param {Context} context commit context
  */
  MyGridLayout.prototype.commit = function commit(context) {
    var transform = context.transform;
    var opacity = context.opacity;
    var origin = context.origin;
    var size = context.size;

    var cols = this.options.dimensions[0];
    var rows = this.options.dimensions[1];

    if (size[0] !== this._contextSizeCache[0] || size[1] !== this._contextSizeCache[1] || cols !== this._dimensionsCache[0] || rows !== this._dimensionsCache[1]) {
      _reflow.call(this, size, cols, rows);
    }

    var sequence = this.sequence;
    var result = [];
    var currIndex = 0;
    while (sequence && (currIndex < this._modifiers.length)) {
      var item = sequence.get();
      var modifier = this._modifiers[currIndex];
      if (currIndex >= this._activeCount && this._states[currIndex].opacity.isActive()) {
        this._modifiers.splice(currIndex, 1);
        this._states.splice(currIndex, 1);
      }
      if (item) {
        result.push(
          modifier.modify({
            origin: origin,
            target: item.render()
          })
        );
      }
      sequence = sequence.getNext();
      currIndex++;
    }

    if (size) transform = Transform.moveThen([-size[0]*origin[0], -size[1]*origin[1], 0], transform);
    return {
      transform: transform,
      opacity: opacity,
      size: size,
      target: result
    };
  };

  FView.registerView('MyGridLayout', MyGridLayout);

});
