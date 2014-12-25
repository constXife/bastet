"use strict";

angular
  .module('bastet').directive('basGraph', ['$log', function($log) {
    return {
      restrict: 'E',
      scope: {
        sensor: '@'
      },
      link: function(scope, element, attrs) {
        var sensor = {}, sensorData = [], data = [];

        function render() {
          for(var i = 0; i < sensorData.length; i++) {
            var hash = {
              x: moment(sensorData[i].created_at).unix(),
              y: sensorData[i].value
            };
            data.push(hash);
          }
          data.reverse();

          var graph = new Rickshaw.Graph( {
            element: document.querySelector("#graph"),
            width: 1024,
            height: 300,
            renderer: 'line',
            preserve: true,
            series: [ {
              name: sensor.name,
              data: data,
              color: '#564f8a'
            } ],
            min: -10,
            max: 40,
            interpolation: 'linear'
          } );

          var time = new Rickshaw.Fixtures.Time();
          var timeUnit = {
            name: 'hour',
            seconds: 3600,
            formatter: function(d) {
              return moment.tz(d, 'UTC').clone().tz('Asia/Novosibirsk').format('HH:mm');
            }
          };
          var x_axis = new Rickshaw.Graph.Axis.Time({
            graph: graph,
            timeUnit: timeUnit
          });

          var y_axis = new Rickshaw.Graph.Axis.Y( {
            graph: graph,
            orientation: 'left',
            ticksTreatment: 'glow',
            tickFormat: function(y) {
              return y + "˚";
            },
            element: document.getElementById('y_axis')
          } );

          graph.render();

          var hoverDetail = new Rickshaw.Graph.HoverDetail( {
            graph: graph,
            formatter: function(series, x, y) {
              var time = moment.tz(new Date(x * 1000), 'UTC');
              var timeLocal = time.clone().tz('Asia/Novosibirsk').format('llll');

              var date = '<span class="date">' + timeLocal + '</span>';
              var content = series.name + ": " + y + '˚<br>' + date;
              return content;
            }
          } );
        }

        scope.$watch('sensor', function() {
          if (scope.sensor == '{}') {
            return;
          }

          $log.debug('sensor watch event');

          sensor = JSON.parse(scope.sensor);
          sensorData = sensor.data;

          render();
        });

//        scope.$watch(attrs.sensor, function() {
//          updateData();
//        });
//
//        function updateData() {
//          $timeout(function() {
//            var parsedData = JSON.parse(attrs['sensor']), hash = {}, hashData = [];
//
//            for (var i = 0; i < parsedData.length; i++) {
//              hash = {
//                datetime: moment(parsedData[i].created_at).toDate(),
//                value: parsedData[i].value
//              };
//
//              hashData.push(hash);
//            }
//
//            data_graphic({
//              title: attrs.title,
//              data: hashData,
//              width: 2880,
//              height: 250,
//              target: '#' + angular.element(element)[0].id,
//              x_accessor: "datetime",
//              y_accessor: "value",
//              max_y: 50,
//              min_y: -50,
//              interpolate: "monotone",
//              transition_on_update: true,
//              show_years: false,
//              y_label: '°C',
//              xax_count: 1440,
//              xax_format: function(d) {
//                var df = d3.time.format('%H:%m');
//                return df(d);
//              }
//            });
//          }, 1000);
//        }
      }
    }
  }]);