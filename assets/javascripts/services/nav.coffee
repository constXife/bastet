angular.module('uiRouter', ['ui.router', 'ngAnimate'])
  .run ['$rootScope', '$state', '$stateParams', ($rootScope, $state, $stateParams) ->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams
  ]
