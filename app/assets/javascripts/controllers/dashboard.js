"use strict";

angular.module('elf')
  .controller('DashboardCtl', ['$scope', '$log', '$timeout', '$window', 'config', 'Sensor', function($scope, $log, $timeout, $window, config, Sensor) {
    $scope.isLoading = true;
    $scope.sensors = Sensor.index();
    $scope.sensors.$promise.then(function() {
      $scope.isLoading = false;
    });

    var ws = new WebSocket('ws://' + config.websockets_host + '/');

    ws.onopen = function() {
      $log.debug('Connection opened...');

      $timeout(function() {
        ws.send('');
      }, 30000, false);
    };

    ws.onclose = function() {
      $log.debug('Connection closed...');
      $timeout.cancel();
    };

    $window.onbeforeunload = function() {
      $log.debug('Closing page');
      ws.onclose = function () {};
      ws.close();
    };

    ws.onmessage = function(evt) {
      var data = JSON.parse(evt.data);

      if (!data) {
        $log.debug('Empty or corrupted data');
        return false;
      } else {
        $log.debug('Data received');
      }

      var sensor = data.sensor, sensorsLength = $scope.sensors.length, exists = false;

      for (var i = 0; i < sensorsLength; i++) {
        if ($scope.sensors[i].id == sensor.id) {
          $log.debug('Sensor exists. Updating…');
          exists = true;

          $scope.$apply(function() {
            $scope.sensors[i] = sensor;
            $scope.sensors[i].data[0].value = 30.2423;
          });
        }
      }

      if (!exists) {
        $log.debug("Sensor doesn't exists. Adding new…");
        $scope.$apply(function() {
          $scope.sensors.push(sensor);
        });
      }
    };
  }]);