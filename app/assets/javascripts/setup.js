"use strict";

angular.module('bastet')
  .config(
    ['$httpProvider', '$stateProvider', '$urlRouterProvider', '$logProvider', 'config', 'routes',
    function($httpProvider, $stateProvider, $urlRouterProvider, $logProvider, config, routes) {
    $httpProvider.defaults.headers.common.Accept = 'application/json';

    $urlRouterProvider.when('', '/dashboard');

    $stateProvider = routes.get($stateProvider);

    $logProvider.debugEnabled(config.is_development);
  }
]);

angular.module('bastet').run(['amMoment', function(amMoment) {
  amMoment.changeLocale('ru');
}]);
