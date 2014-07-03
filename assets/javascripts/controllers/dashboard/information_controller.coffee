@app
  .controller 'InformationController', ['$scope', '$rootScope', '$http', '$location', 'Auth', '$i18next', 'localStorageService', ($scope, $rootScope, $http, $location, Auth, $i18next, localStorageService) ->
    $scope.random = ->
      value = Math.floor((Math.random() * 100) + 1)
      type = ''

      if (value < 25)
        type = 'success'
      else if (value < 50)
        type = 'info'
      else if (value < 75)
        type = 'warning'
      else
        type = 'danger'

      $scope.showWarning = (type == 'danger' || type == 'warning')
      $scope.dynamic = value
      $scope.type = type

    $scope.random()
  ]