"use strict";

angular
  .module("bastet.services").factory("Sensor", ['$resource', function($resource) {
    return $resource("/api/sensors/:id", {id: '@id'},
      {
        index: {
          method: 'GET',
          responseType: 'json',
          isArray: true,
          transformResponse: function (data) {
            if (typeof data === 'string') {
              data = JSON.parse(data);
            }
            return data.sensors;
          }
        },
        show: {
          method: 'GET',
          responseType: 'json',
          transformResponse: function (data) {
            if (typeof data === 'string') {
              data = JSON.parse(data);
            }
            return data.sensor;
          }
        }
      }
    );
  }]);
