# FlexGrid - A flexible and responsive grid layout

A plugin for [famous-views](http://famous-views.meteor.com).

This [famo.us](http://famo.us) plugin brings a flexible grid layout in Blaze or Jade templating for [Meteor.js](https://www.meteor.com). This plugin is inspired from [Shu Liu](https://twitter.com/shupacio)'s [Pen](http://codepen.io/shupac/pen/zGFiE).

## Usage
Starts with the usual and add some packages:
```bash
meteor create mydevices
cd mydevices
mkdir client
meteor add gadicohen:famous-views pierreeric:fview-flexgrid
# From here you can choose your favorite Famo.us provider, mine is Raix's one.
meteor add raix:famono
```

You can choose to write your HTML templates with Blaze or
with [Maxime Quandalle's Jade](https://github.com/mquandalle/meteor-jade).
```bash
meteor add mquandalle:jade
```

For your logic, you can write yours in vanilla JS or in [CoffeeScript](https://atmospherejs.com/meteor/coffeescript):
```bash
meteor add coffeescript
```

And then in `client` directory, call your FlexGrid like this:
```jade
+FlexGrid...
```

To fill your grid and initiate the library, you need an helper and an import of the `Easing` animations provided by default:
```coffee
# Polyfills are necessary if you are using raix:famono
famous.polyfills

# If you are using pierreeric:cssc-famous, you don't need this line
# as it imports the required CSS files for Famo.us in CS (therefore no
# CSS file is required which speeds up your apps and avoid tempering
# with the JS engine).
# famous.core.famous

# Required by this package
Easing = famous.transitions.Easing
```
