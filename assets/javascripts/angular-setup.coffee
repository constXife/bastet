@app = angular.module('elf', ['ngResource', 'LocalStorageModule', 'ui.router', 'uiRouter', 'jm.i18next'])

angular.module('jm.i18next').config ['$i18nextProvider', ($i18nextProvider) ->
    $i18nextProvider.options = {
      lng: 'ru',
      fallbackLng: 'en',
      useCookie: false
      useLocalStorage: false
      resGetPath: '/assets/locales/__lng__/__ns__.json'
    }
  ]

@app
  .config ['$httpProvider', ($httpProvider) ->
    $httpProvider.defaults.headers.common.Accept = 'application/json'
  ]

@app.run ($templateCache, $window) ->
  templates = $window.JST
  for fileName, fileContent of templates
    $templateCache.put(fileName, fileContent())

@app.config ($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider) ->
  access = routingConfig.accessLevels

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
      template: "<ui-view/>",
      data: {
        access: access.user
      }
    })
    .state('dashboard', {
      url: '/dashboard',
      abstract: true
      template: "<ui-view/>",
      data: {
        access: access.user
      }
    })
    .state('dashboard.information', {
      url: '/information',
      templateUrl: 'dashboard/information'
    })
    .state('dashboard.comfort', {
      url: '/comfort',
      templateUrl: 'dashboard/comfort'
    })
    .state('dashboard.security', {
      url: '/security',
      templateUrl: 'dashboard/security'
    })
    .state('user.settings', {
      url: '/settings',
      templateUrl: 'settings/index'
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

@app.run ['$rootScope', '$state', 'Auth', ($rootScope, $state, Auth) ->
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