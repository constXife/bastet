//= require_self
//= require_tree ./services

angular.module('elf.services', []);
angular.module('elf.constants', []);
angular.module('elf.namespace', ['elf.constants', 'elf.services']);
angular.module('elf', [
  'ngAnimate', 'ngResource', 'ui.router', 'elf.namespace', 'templates', 'angularMoment'
]);