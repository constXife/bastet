angular
  .module('elf')
  .controller 'LoginController', ['$scope', '$http', '$location', '$rootScope', 'Auth', ($scope, $http, $location, $rootScope, Auth) ->
    $scope.login = ->
      Auth.login(
          username: $scope.username,
          password: $scope.password,
        , (res) ->
          $location.path('/')
        , (err) ->
          $rootScope.error = "Failed to login"
    )
  ]