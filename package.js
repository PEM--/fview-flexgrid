Package.describe({
  name: 'pierreeric:fview-flexgrid',
  summary: 'A flexible and responsive grid for Meteor\'s famous-views.',
  version: '0.1.1',
  git: 'https://github.com/PEM--/fview-flexgrid'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('mjn:famous@0.3.4', 'client', { weak: true });
  api.use('raix:famono@0.9.27', { weak: true });
  api.use([
    'coffeescript@1.0.5',
    'gadicohen:famous-views@0.1.30'
  ], 'client');
  api.addFiles(['FviewFlexgrid.coffee'], 'client');
});
