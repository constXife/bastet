"use strict";

angular.module('elf')
  .config(function($httpProvider, $stateProvider, $urlRouterProvider, routes) {
    $httpProvider.defaults.headers.common.Accept = 'application/json';

    $urlRouterProvider.when('', '/dashboard');

    $stateProvider = routes.get($stateProvider);
  }
);

angular.module('elf').run(function(amMoment) {
  amMoment.changeLocale('ru');
});
