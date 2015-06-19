"use strict";

angular.module('bastet')
  .controller('SensorsShowCtl', ['$scope', '$log', '$stateParams', '$timeout', '$window', '$websocket', 'config', 'Sensor',
    function($scope, $log, $stateParams, $timeout, $window, $websocket, config, Sensor) {
      $scope.isLoading = true;
      $scope.sensor = Sensor.show({id: $stateParams.sensor_id, daily: true});
      $scope.sensor.$promise.then(function() {
        $scope.isLoading = false;
      });

      var ws = new $websocket.$new('ws://localhost:9292/ws/dashboard');
      $log.debug('WS host is: ' + 'ws://localhost:9292/ws/dashboard');

      ws.$on('$open', function () {
        $log.debug('Connection opened...');

        $timeout(function() {
          $log.debug('ping');
          ws.$emit('pong', {});
        }, 30000, false);
      });

      ws.$on('$close', function () {
        $log.debug('Connection closed...');
        $timeout.cancel();
      });

      ws.$on('pong', function () {
        console.log('pong');
      });

      ws.$on('sensor', function (data) {
        var data = JSON.parse(data);

        if (!data) {
          $log.debug('Empty or corrupted data');
          return false;
        } else {
          $log.debug('Data received');
        }

        var sensor = data.sensor;

        if ($scope.sensor.id == sensor.id) {
          $scope.$apply(function() {
            Sensor.show({id: $stateParams.sensor_id, daily: true}).$promise.then(function(sensor) {
              $log.debug('Data updated');
              $scope.sensor = sensor;
            });
          });
        }
      });
    }]);