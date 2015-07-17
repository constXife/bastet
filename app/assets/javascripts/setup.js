"use strict";

angular.module('bastet')
  .config(function($httpProvider, $stateProvider, $urlRouterProvider,
                   $logProvider, config, routes) {
    $httpProvider.defaults.headers.common.Accept = 'application/json';

    $urlRouterProvider.when('', '/dashboard');

    $stateProvider = routes.get($stateProvider);

    $logProvider.debugEnabled(config.is_development);
  }
);

angular.module('bastet').run(function(amMoment) {
  amMoment.changeLocale('ru');
});
