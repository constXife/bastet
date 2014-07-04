@app
  .controller 'InformationController', ['$scope', '$rootScope', '$http', '$location', 'Auth', '$i18next', 'localStorageService', ($scope, $rootScope, $http, $location, Auth, $i18next, localStorageService) ->
    $scope.random = ->
      value = Math.floor((Math.random() * 100) + 1)
      type = ''

      if (value < 25)
        type = 'success'
      else if (value < 50)
        type = 'info'
      else if (value < 75)
        type = 'warning'
      else
        type = 'danger'

      $scope.showWarning = (type == 'danger' || type == 'warning')
      $scope.dynamic = value
      $scope.type = type

    $scope.random()

    $scope.gauges = []

    $scope.createGauge = (name, label, min, max) ->
      config = {
        size: 120,
        label: label,
        min: min,
        max: max,
        minorTicks: 5
      }

      range = config.max - config.min
      config.greenZones = [{ from: config.min + range*0.95, to: config.max }];
      config.yellowZones = [{ from: config.min + range*0.75, to: config.min + range*0.9 }];
      config.redZones = [{ from: config.min + range*0.9, to: config.max }];

      gauge = {name: name}
      gauge[name] = new Gauge(name + "GaugeContainer", config)
      gauge[name].render();
      $scope.gauges.push(gauge)

    $scope.updateGauges = ->
      for gauge in $scope.gauges
        name = gauge.name
        value = $scope.getRandomValue(gauge[name])
        gauge[name].redraw(value);

    $scope.getRandomValue = (gauge) ->
      overflow = 0;
      1 - overflow + (100 - 1 + overflow*2) *  Math.random()

    $scope.createGauge("memory", "Вода", 1, 100)
    $scope.createGauge("cpu", "Электричество", 1, 100)
    $scope.createGauge("network", "Интернет", 1, 100)

    setInterval($scope.updateGauges, 1000);

    margin = { top: 50, right: 0, bottom: 100, left: 30 }
    width = 960 - margin.left - margin.right
    height = 430 - margin.top - margin.bottom
    gridSize = Math.floor(width / 24)
    legendElementWidth = gridSize*2
    buckets = 9
    colors = ["#ffffd9","#edf8b1","#c7e9b4","#7fcdbb","#41b6c4","#1d91c0","#225ea8","#253494","#081d58"]
    days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    times = ["1a", "2a", "3a", "4a", "5a", "6a", "7a", "8a", "9a", "10a", "11a", "12a", "1p", "2p", "3p", "4p", "5p", "6p", "7p", "8p", "9p", "10p", "11p", "12p"]

    d3.tsv "/data.tsv", (d) ->
      {
        day: +d.day,
        hour: +d.hour,
        value: +d.value
      }
    ,
      (error, data) ->
        colorScale = d3.scale.quantile()
                    .domain([0, buckets - 1, d3.max(data, (d) -> d.value)])
                    .range(colors)

        svg = d3.select("#resource_usage_map").append("svg")
              .attr("width", width + margin.left + margin.right)
              .attr("height", height + margin.top + margin.bottom)
              .append("g")
              .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

        dayLabels = svg.selectAll(".dayLabel")
                    .data(days)
                    .enter().append("text")
                    .text( (d) -> d)
                    .attr("x", 0)
                    .attr("y", (d, i) -> i * gridSize)
                    .style("text-anchor", "end")
                    .attr("transform", "translate(-6," + gridSize / 1.5 + ")")
                    .attr("class", (d, i) -> (i >= 0 && i <= 4) ? "dayLabel mono axis axis-workweek" : "dayLabel mono axis")

        timeLabels = svg.selectAll(".timeLabel")
                    .data(times)
                    .enter().append("text")
                    .text((d) -> d)
                    .attr("x", (d, i) -> i * gridSize)
                    .attr("y", 0)
                    .style("text-anchor", "middle")
                    .attr("transform", "translate(" + gridSize / 2 + ", -6)")
                    .attr("class", (d, i) -> ((i >= 7 && i <= 16) ? "timeLabel mono axis axis-worktime" : "timeLabel mono axis"))

        heatMap = svg.selectAll(".hour")
                  .data(data)
                  .enter().append("rect")
                  .attr("x", (d) -> (d.hour - 1) * gridSize)
                  .attr("y", (d) -> (d.day - 1) * gridSize)
                  .attr("rx", 4)
                  .attr("ry", 4)
                  .attr("class", "hour bordered")
                  .attr("width", gridSize)
                  .attr("height", gridSize)
                  .style("fill", colors[0]);

        heatMap.transition().duration(1000)
                .style("fill", (d) -> colorScale(d.value))

        heatMap.append("title").text((d) -> d.value)

        legend = svg.selectAll(".legend")
                .data([0].concat(colorScale.quantiles()), (d) -> d)
                .enter().append("g")
                .attr("class", "legend");

        legend.append("rect")
              .attr("x", (d, i) -> legendElementWidth * i)
              .attr("y", height)
              .attr("width", legendElementWidth)
              .attr("height", gridSize / 2)
              .style("fill", (d, i) -> colors[i])

        legend.append("text")
              .attr("class", "mono")
              .text((d) -> "≥ " + Math.round(d))
              .attr("x", (d, i) -> legendElementWidth * i)
              .attr("y", height + gridSize);

  ]