'use strict';

/**
 * @ngdoc overview
 * @name frontApp
 * @description
 * # frontApp
 *
 * Main module of the application.
 */
angular
  .module('frontApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.router',
    'ui.bootstrap',
    'jm.i18next'
  ])
  .config(function ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider, $i18nextProvider) {
    $i18nextProvider.options = {
      fallbackLng: 'en',
      supportedLngs: ['ru', 'en'],
      useCookie: true,
      resGetPath: '/locales/__lng__/__ns__.json'
    };

    $urlRouterProvider.when('/', '/dashboard');
    $urlRouterProvider.when('/dashboard', '/dashboard/information');

    $stateProvider
      .state('public', {
        abstract: true,
        template: '<ui-view/>',
        views: {
          '@': {},
          "header": { templateUrl: '/views/partials/header.html' }
        }
      })
      .state('public.404', {
        url: '/404/',
        templateUrl: '404'
      })
      .state('dashboard', {
        url: '/dashboard',
        abstract: true,
        views: {
          '@': {},
          "header": { templateUrl: '/views/partials/header.html' }
        }
      })
      .state('dashboard.information', {
        url: '/information',
        views: {
          '@': {
            templateUrl: '/views/dashboard/information.html'
          }
        }
      })
      .state('dashboard.comfort', {
        url: '/comfort',
        views: {
          '@': { templateUrl: '/views/dashboard/comfort.html' }
        }
      })
      .state('dashboard.security', {
        url: '/security',
        views: {
          '@': { templateUrl: '/views/dashboard/security.html' }
        }
      })
      .state('public.settings', {
        url: '/settings',
        views: {
          '@': { templateUrl: '/views/settings/index.html' }
        }
      });

    $locationProvider.html5Mode(true);
  });


//[Error] Failed to load resource: the server responded with a status of 404 (Not Found) (header.html, line 0)
//[Error] Failed to load resource: the server responded with a status of 404 (Not Found) (information.html, line 0)
