@app = angular.module('elf', ['ngResource', 'LocalStorageModule', 'ui.router', 'uiRouter', 'jm.i18next', 'ui.bootstrap'])

@app.run ($templateCache, $window) ->
  templates = $window.JST
  for fileName, fileContent of templates
    $templateCache.put(fileName, fileContent())

@app.config ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider, $i18nextProvider) ->
  access = routingConfig.accessLevels

  $httpProvider.defaults.headers.common.Accept = 'application/json'

  $i18nextProvider.options = {
    fallbackLng: 'en'
    detectLngFromHeaders: true
    supportedLngs: ['ru', 'en']
    useCookie: true
    resGetPath: '/assets/locales/__lng__/__ns__.json'
  }

  $urlRouterProvider.when('/', '/dashboard')
  $urlRouterProvider.when('/dashboard', '/dashboard/information')

  $stateProvider
    .state('public', {
      abstract: true,
      template: '<ui-view/>',
      data: {
        access: access.public
      }
    })
    .state('public.404', {
      url: '/404/',
      templateUrl: '404'
    })

  $stateProvider
    .state('anon', {
      abstract: true,
      template: "<ui-view/>",
      data: {
        access: access.anon
      }
    })
    .state('anon.login', {
        url: '/login/',
        templateUrl: 'login',
        controller: 'LoginController'
    })

  $stateProvider
    .state('user', {
      abstract: true,
      data: {
        access: access.user
      },
      views: {
        '@': {},
        "header": { templateUrl: "partials/header" },
      }
    })
    .state('dashboard', {
      url: '/dashboard',
      abstract: true
      data: {
        access: access.user
      },
      views: {
        '@': {},
        "header": { templateUrl: "partials/header" },
      }
    })
    .state('dashboard.information', {
      url: '/information'
      views: {
        '@': {
          templateUrl: 'dashboard/information'
          controller: 'InformationController'
        }
      }
    })
    .state('dashboard.comfort', {
      url: '/comfort',
      views: {
        '@': { templateUrl: 'dashboard/comfort' }
      }
    })
    .state('dashboard.security', {
      url: '/security',
      views: {
        '@': { templateUrl: 'dashboard/security' }
      }
    })
    .state('user.settings', {
      url: '/settings',
      views: {
        '@': { templateUrl: 'settings/index' }
      }
    })

#  $urlRouterProvider.otherwise('/404/')

  $locationProvider.html5Mode(true)

  $httpProvider.interceptors.push ($q, $location) ->
    {
      'responseError': (response) ->
        if (response.status == 401 || response.status == 403)
          $location.path('/login')

        $q.reject(response)
    }

@app.run ['$rootScope', '$state', 'Auth', 'localStorageService', '$i18next', ($rootScope, $state, Auth, localStorageService, $i18next) ->
  $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
    if !Auth.authorize(toState.data.access)
      $rootScope.error = "Seems like you tried accessing a route you don't have access to..."
      event.preventDefault()

      if (fromState.url == '^')
        if (Auth.isLoggedIn())
          $state.go('user.home')
        else
          $rootScope.error = null
          $state.go('anon.login')
]