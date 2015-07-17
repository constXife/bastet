//= require_self
//= require_tree ./services

angular.module('bastet.services', []);
angular.module('bastet.constants', []);
angular.module('bastet.namespace', ['bastet.constants', 'bastet.services']);
angular.module('bastet', [
  'bastet.namespace', 'ngAnimate', 'ngResource', 'ui.router', 'templates',
  'angularMoment'
]);