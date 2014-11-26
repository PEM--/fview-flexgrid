// Theming done in CS
var css = new CSSC();
var shadow = '0 ' + CSSC.px(3) + ' ' + CSSC.px(10) + ' ' + CSSC.black;
css.add('body', {
  backgroundColor: CSSC.darkgray,
  color: CSSC.white,
  textAlign: 'center'
});
css.add('.surf', {
  lineHeight: CSSC.px(100),
  borderRadius: CSSC.px(5),
  textShadow: shadow,
  boxShadow: shadow
});

// Set FView logging at its bare minimum
//Logger.setLevel('famous-views', 'info');

// Polyfills are necessary if you are using raix:famono
famous.polyfills;
/* If you are using pierreeric:cssc-famous, you don't need this line
 as it imports the required CSS files for Famo.us in CS (therefore no
 CSS file is required which speeds up your apps and avoid tempering
 with the JS engine). */
//famous.core.famous

// Required by this package
var Engine = famous.core.Engine;

FView.ready(function() {
  console.info("%c\nfamous-views started\n",
    'font-weight: 300; color: #ec5f3e; font-size: x-large; ' +
    'font-family: \'Lato\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; ' +
    '-webkit-font-smoothing: antialiased;');
});

Template.flexGridExample.rendered = function() {
  var fscrollview = FView.byId('scrollview');
  Engine.pipe(fscrollview.view);
};

Template.flexGridExample.helpers({
  items: function() {
    var NUM_SURFACES =  50;
    var idx;
    var surfaces = [];
    for (idx = 0; idx <= NUM_SURFACES - 1; idx++) {
      surfaces.push({
        name: 'Surface ' + (idx + 1),
        color: 'backgroundColor: hsl(' + (idx * 360 / NUM_SURFACES) + ', 85%, 40%)'
      });
    }
    return surfaces;
  }
});
