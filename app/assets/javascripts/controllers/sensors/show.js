"use strict";

angular.module('bastet')
  .controller('SensorsShowCtl', ['$scope', '$log', '$stateParams', '$timeout', '$window', 'config', 'Sensor',
    function($scope, $log, $stateParams, $timeout, $window, config, Sensor) {
      $scope.isLoading = true;
      $scope.sensor = Sensor.show({id: $stateParams.sensor_id, daily: true});
      $scope.sensor.$promise.then(function() {
        $scope.isLoading = false;
      });

      var ws = new WebSocket('ws://' + config.websockets_host + '/ws/dashboard');
      $log.debug('WS host is: ' + 'ws://' + config.websockets_host + '/ws/dashboard');

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
        $log.debug('message');

        var data = JSON.parse(evt.data);

        if (!data) {
          $log.debug('Empty or corrupted data');
          return false;
        } else {
          $log.debug('Data received');
        }

        var sensor = data.sensor;

        if ($scope.sensor.id == sensor.id) {
          $scope.$apply(function() {
            $scope.sensor = sensor;
          });
        }
      };
    }]);