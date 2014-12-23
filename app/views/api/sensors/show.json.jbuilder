json.sensor do
  if @sensor_data
    json.partial! 'api/sensors/object', sensor: @sensor, sensor_data: @sensor_data
  else
    json.partial! 'api/sensors/object', sensor: @sensor
  end
end