"use strict";

angular.module('elf.constants')
  .constant('routes', {
    get: function($stateProvider) {
      $stateProvider
        .state('dashboard', {
          url: '/dashboard',
          views: {
            "": {
              controller: 'DashboardCtl',
              templateUrl: 'index.html'
            },
            "header": { templateUrl: 'shared/header.html' }
          }
        })
    }
  });