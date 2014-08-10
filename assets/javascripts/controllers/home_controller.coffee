@app
  .controller 'HomeController', ['$scope', '$rootScope', '$http', '$location', 'Auth', '$i18next', 'localStorageService', ($scope, $rootScope, $http, $location, Auth, $i18next, localStorageService) ->
    $scope.user = Auth.user
    $scope.userRoles = Auth.userRoles
    $scope.accessLevels = Auth.accessLevels
    $scope.api_version = window.api_version

    $scope.setLang = (lang) ->
      $i18next.options.postProcess = '';
      $i18next.options.lng = lang;

    $scope.logout = ->
      Auth.logout ->
        $location.path('/login/')
      , ->
        $rootScope.error = "Failed to logout"
  ]