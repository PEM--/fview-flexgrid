css = new CSSC
css.add '.surf',
  color: CSSC.yellow
  textAlign: 'center'

# Polyfills are necessary if you are using raix:famono
famous.polyfills

Logger.setLevel 'famous-views', 'info'

# If you are using pierreeric:cssc-famous, you don't need this line
# as it imports the required CSS files for Famo.us in CS (therefore no
# CSS file is required which speeds up your apps and avoid tempering
# with the JS engine).

# Required by this package
# TODO See if import could be better created
###
Easing = famous.transitions.Easing
Timer = famous.utilities.Timer
###

Engine = null
Scrollview = null
View = null

FView.ready ->
  # TODO Don't work, see FView code: FView.attrEvalAllowedKeys = ['properties']
  # Create a test suite
  #FView.attrEvalAllowedKeys = '*'

  # TODO Is that necessary? Should be transmitted by packages as FView already
  # use this.
  Engine = famous.core.Engine

  console.info "%c\nfamous-views started\n", \
    "font-weight: 300; color: #ec5f3e; font-size: x-large; \
    font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif; \
    -webkit-font-smoothing: antialiased;"

Template.flexGridExample.rendered = ->
  # TODO integrate the Scrollview in the widget as it can't work without it
  fscrollview = FView.byId 'scrollview'
  Engine.pipe fscrollview.view

Template.flexGridExample.helpers
  items: ->
    NUM_SURFACES =  50
    (
      {
        name: "Surface #{idx}"
        prop: "backgroundColor: hsl(#{idx * 360 / NUM_SURFACES}, 60%, 40%)"
      } for idx in [1..NUM_SURFACES]
    )
