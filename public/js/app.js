angular.module('app', [
  'config',
  'routes',
  'services',
  'auth',
  'projects'
]);

angular.module('config', []);
angular.module('services', []);
angular.module('routes', ['ngRoute']);