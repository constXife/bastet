//= require_self
//= require_tree ./services

angular.module('elf.services', []);
angular.module('elf.constants', []);
angular.module('elf.namespace', ['elf.constants', 'elf.services']);
angular.module('elf', [
  'elf.namespace', 'ngAnimate', 'ngResource', 'ui.router', 'templates', 'angularMoment'
]);