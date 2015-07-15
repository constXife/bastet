"use strict";

angular.module('bastet')
  .controller('SensorsShowCtl', function($scope, $stateParams, Sensor) {
      $scope.isLoading = true;
      $scope.sensor = Sensor.show({id: $stateParams.sensor_id, daily: true});
      $scope.sensor.$promise.then(function () {
        $scope.isLoading = false;
      });
    });