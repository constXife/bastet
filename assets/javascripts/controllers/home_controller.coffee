angular
  .module('elf')
  .controller 'HomeController', ['$scope', '$rootScope', '$http', '$location', 'Auth', ($scope, $rootScope, $http, $location, Auth) ->
    $scope.user = Auth.user
    $scope.userRoles = Auth.userRoles
    $scope.accessLevels = Auth.accessLevels

    $scope.logout = ->
      Auth.logout ->
        $location.path('/login/')
      , ->
        $rootScope.error = "Failed to logout"
  ]