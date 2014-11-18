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

And then in `client` directory, call your devices like this:
```jade
+FlexGrid...
```
