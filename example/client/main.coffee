css = new CSSC
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
Easing = famous.transitions.Easing
