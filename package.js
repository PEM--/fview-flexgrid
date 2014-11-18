Package.describe({
  name: 'pierreeric:fview-flexgrid',
  summary: 'A flexible and responsive grid for Meteor\'s famous-views.',
  version: '0.1.0',
  git: 'https://github.com/PEM--/fview-flexgrid'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('mjn:famous@0.3.1_2', 'client', { weak: true });
  api.use('raix:famono@0.9.16', { weak: true });
  api.use([
    'coffeescript@1.0.4',
    'gadicohen:famous-views@0.1.26'
  ], 'client');
  api.addFiles('fview-flexgrid.coffee', 'client');
});
