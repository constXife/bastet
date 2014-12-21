"use strict";

angular.module('elf')
  .controller('DashboardCtl', function($scope, Sensor) {
    $scope.sensor = Sensor.show({id: 1, daily: true});
  });