"use strict";

angular.module('bastet')
  .controller('DashboardCtl', ['$scope', '$log', '$timeout', '$window', '$websocket', 'config', 'Sensor',
    function($scope, $log, $timeout, $window, $websocket, config, Sensor) {
    $scope.isLoading = true;
    $scope.sensors = Sensor.index();
    $scope.sensors.$promise.then(function() {
      $scope.isLoading = false;
    });
  }]);