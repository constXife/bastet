"use strict";

angular.module('bastet')
  .controller('DashboardCtl', function($scope, $log, Sensor) {
    $scope.isLoading = true;
    $scope.sensors = Sensor.index();
    $scope.sensors.$promise.then(function() {
      $scope.isLoading = false;
    });

    window.App.messages = window.App.cable.subscriptions.create('SensorsChannel', {
      received: function(data) {
        $log.debug(data);
      }
    });
  });