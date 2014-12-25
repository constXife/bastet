"use strict";

angular.module('bastet.constants')
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
        .state('sensors', {
          url: '/sensors',
          abstract: true,
          views: {
            "header": { templateUrl: 'shared/header.html' }
          }
        })
        .state('sensors.show', {
          url: '/:sensor_id/',
          views: {
            "@": {
              controller: 'SensorsShowCtl',
              templateUrl: 'sensors/show.html'
            }
          }
        })
    }
  });