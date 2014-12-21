"use strict";

angular.module('elf')
  .controller('DashboardCtl', function($scope, Sensor) {
    $scope.sensors = Sensor.index();
  });