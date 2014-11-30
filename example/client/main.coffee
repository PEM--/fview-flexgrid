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

overlay = null

setOverlayOpacity = ->
  currentOpacity = overlay.modifier.getOpacity()
  nextOpacity = if currentOpacity > .5 then 0 else 1
  overlay.modifier.setOpacity nextOpacity, duration: 300

Template.overlay.rendered = ->
  overlay = FView.byId 'overlay'
  Timer.setInterval setOverlayOpacity, 2000

Template.flexGridExample.rendered = ->
  fscrollview = FView.byId 'scrollview'
  Engine.pipe fscrollview.view

Template.flexGridExample.helpers
  items: ->
    NUM_SURFACES =  50
    (
      {
        name: "Surface #{idx}"
        color: "backgroundColor: hsl(#{idx * 360 / NUM_SURFACES}, 85%, 40%)"
      } for idx in [1..NUM_SURFACES]
    )
