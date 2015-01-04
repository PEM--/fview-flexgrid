# Theming done in CS
css = new CSSC
shadow = "0 #{CSSC.px 3} #{CSSC.px 10} #{CSSC.black}"
css
.add 'body',
  backgroundColor: CSSC.darkgray
  color: CSSC.white
  textAlign: 'center'
.add '.surf',
  lineHeight: CSSC.px 100
  borderRadius: CSSC.px 5
  textShadow: shadow
  boxShadow: shadow
.add '.overlay',
  backgroundColor: (new CSSC.Clr [0, 0, 0, .7]).rgba()
  borderRadius: CSSC.px 20
  padding: "0 #{CSSC.px 30}"
.add '.text-overlay',
  fontSize: CSSC.px 25

# Set FView logging at its bare minimum
Logger.setLevel 'famous-views', 'info'

# Polyfills are necessary if you are using raix:famono
famous.polyfills
# If you are using pierreeric:cssc-famous, you don't need this line
# as it imports the required CSS files for Famo.us in CS (therefore no
# CSS file is required which speeds up your apps and avoid tempering
# with the JS engine).
#famous.core.famous

Engine = famous.core.Engine
Timer = famous.utilities.Timer

FView.ready ->
  console.info "%c\nfamous-views started\n", \
    "font-weight: 300; color: #ec5f3e; font-size: x-large; \
    font-family: 'Lato', 'Helvetica Neue', Helvetica, Arial, sans-serif; \
    -webkit-font-smoothing: antialiased;"

setOverlayOpacity = ->
  overlay = FView.byId 'overlay'
  return false if overlay is undefined
  currentOpacity = overlay.modifier.getOpacity()
  nextOpacity = if currentOpacity > .5 then 0 else 1
  overlay.modifier.setOpacity nextOpacity, duration: 300

Template.flexGridExample.helpers
  items: -> Surfaces.find()

Template.switchRoute.rendered = ->
  button = (FView.byId 'switchRoute').surface
  button.on 'click', ->
    if Router.current().route.getName() is 'second'
      Router.go '/'
    else
      Router.go '/second'

# Configure router and 2 routes
Router.configure layoutTemplate: 'layout'
Router.route '/',
  action: ->
    @render 'home'
  onAfterAction: ->
    Timer.setTimeout ->
      Timer.setInterval setOverlayOpacity, 2000
      fscrollview = FView.byId 'scrollview'
      Engine.pipe fscrollview.view
    , 100

Router.route '/second'
