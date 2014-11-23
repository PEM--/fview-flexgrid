css = new CSSC()
css.add '.red-bg',
  backgroundColor: CSSC.red
  color: CSSC.yellow

# Polyfills are necessary if you are using raix:famono
famous.polyfills

# If you are using pierreeric:cssc-famous, you don't need this line
# as it imports the required CSS files for Famo.us in CS (therefore no
# CSS file is required which speeds up your apps and avoid tempering
# with the JS engine).
# famous.core.famous

# Required by this package
###
Easing = famous.transitions.Easing
Entity = famous.core.Entity
famous.modifiers.StateModifier
famous.surfaces.ContainerSurface
###

Engine = null

FView.ready ->
  Engine = famous.core.Engine
  console.info "%c\nFView started\n", \
    "font-weight: 300; color: #ec5f3e; font-size: x-large; \
    font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif; \
    -webkit-font-smoothing: antialiased;"

Template.famousInit.rendered = ->
  console.log 'Including template', FView.from @, 'Container', \
    (FView.byId 'container')

  fscrollview = FView.byId 'scrollview'
  Engine.pipe [fscrollview._view]
  fflexgrid = FView.byId 'flexgrid'

Template.shootIt.helpers
  items: [
    {name: 'Some stuff' }
    {name: 'Other stuff' }
    {name: 'Additional stuff'}
  ]
