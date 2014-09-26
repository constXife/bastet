'use strict';

/**
 * @ngdoc function
 * @name frontApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the frontApp
 */
angular.module('frontApp')
  .controller('MainCtrl', function ($scope, $rootScope) {
    var socket = new WebSocket("ws://" + window.location.hostname + "/api");
    $rootScope.dist = {};
    $scope.isConnected = false;

    socket.onopen = function(e) {
      $scope.isConnected = true;
      socket.send(JSON.stringify({cmd: 'get'}));
    };

    socket.onerror = function(e) {
      Messenger().post({
        message: e.data,
        type: "error"
      })
    };

    socket.onmessage = function(e) {
      var data = JSON.parse(e.data);
      $scope.$broadcast(data['event'], data['body']);
    };

    $scope.$on('api', function(event, args) {
      $scope.$apply(function () {
        $rootScope.api = JSON.parse(args);
      });
    });
  });
