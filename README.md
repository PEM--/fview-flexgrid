# FlexGrid - A flexible and responsive grid layout

A plugin for [famous-views](http://famous-views.meteor.com).

This [Famo.us](http://famo.us) plugin brings a flexible grid layout in Blaze or Jade templating for [Meteor.js](https://www.meteor.com). This plugin is inspired from [Shu Liu](https://twitter.com/shupacio)'s [Pen](http://codepen.io/shupac/pen/zGFiE).

![FlexGrid](https://raw.githubusercontent.com/PEM--/fview-flexgrid/master/assets/output.gif)

## Usage
Starts with the usual and add some packages:
```bash
meteor create mydevices
cd mydevices
mkdir client
meteor add gadicohen:famous-views pierreeric:fview-flexgrid
# From here you can choose your favorite Famo.us provider.
# Mine is raix:famono but it works equally fine with mjn:famous.
meteor add raix:famono
```

> Note that [raix:famono](https://atmospherejs.com/raix/famono) is not only a Famo.us provider. You can use it to import Bower packages, raw Github repos, CDN libraries and local libraries. Putting D3.js, Sortable, Velocity, jQueryUI... in Meteor with it, is a no brainer. A must :star:

You can choose to write your HTML templates with Blaze or
with [Maxime Quandalle's Jade](https://github.com/mquandalle/meteor-jade).
```bash
meteor add mquandalle:jade
```

For your logic, you can write yours in vanilla JS or in [CoffeeScript](https://atmospherejs.com/meteor/coffeescript):
```bash
meteor add coffeescript
```

And then in `client` directory, call your FlexGrid filling it with either a static set of surfaces or a reactive one extracted from your MongoDB:
```jade
+FlexGrid attr1=val1 attr2=val2
```
With the following attributes and the default values:
* `marginTop`: 10
* `marginSide`: 0
* `gutterCol`: 10
* `gutterRow`: 10
* `itemSize`: [200, 150]
* `transition`: A property dictionary for a transition object as in vanilla Famo.us
    * `duration`: 500
    * `curve`: 'easeInOut'

The Github repo has 2 neat examples that should make you on track in no time:
* [A Jade and CoffeeScript example](https://github.com/PEM--/fview-flexgrid/tree/master/example).
* [A canonical HTML/Blaze and vanilla JS](https://github.com/PEM--/fview-flexgrid/tree/master/example%20-%20html%20-%20js).
