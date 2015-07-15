"use strict";

angular.module('bastet')
  .controller('DashboardCtl', function($scope, $log, $timeout, $window, config,
    Sensor) {
      $scope.isLoading = true;
      $scope.sensors = Sensor.index();
      $scope.sensors.$promise.then(function() {
        $scope.isLoading = false;
      });
  });