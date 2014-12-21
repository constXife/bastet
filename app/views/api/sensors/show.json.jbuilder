json.sensor do
  json.partial! 'object', sensor: @sensor, sensor_data: @sensor_data
end