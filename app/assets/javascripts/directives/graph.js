"use strict";

angular
  .module('elf')
  .directive('elGraph', function($timeout) {
    return {
      restrict: 'E',
      link: function(scope, element, attrs) {
        scope.$watch(attrs.sensor, function() {
          updateData();
        });

        function updateData() {
          $timeout(function() {
            var parsedData = JSON.parse(attrs['sensor']), hash = {}, hashData = [];

            for (var i = 0; i < parsedData.length; i++) {
              hash = {
                datetime: moment(parsedData[i].created_at).toDate(),
                value: parsedData[i].value
              };

              hashData.push(hash);
            }

            data_graphic({
              title: attrs.title,
              data: hashData,
              width: 2880,
              height: 250,
              target: '#' + angular.element(element)[0].id,
              x_accessor: "datetime",
              y_accessor: "value",
              max_y: 50,
              min_y: -50,
              interpolate: "monotone",
              transition_on_update: true,
              show_years: false,
              y_label: '°C',
              xax_count: 1440,
              xax_format: function(d) {
                var df = d3.time.format('%H:%m');
                return df(d);
              }
            });
          }, 1000);
        }
      }
    }
  });