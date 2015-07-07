json.(sensor, :id,
              :sid)
json.name sensor.to_s

if defined?(sensor_data) && sensor_data.length > 0
  json.data sensor_data

  sensor_data_map = sensor_data.map(&:value).inject(0, &:+)
  average = 0
  if sensor_data_map > 0
    average = sensor_data_map/sensor_data.length
  end

  json.average average

  json.min do
    min = sensor_data.min_by {|x| x.value}
    json.value min.value
    json.created_at min.created_at
  end
  json.max do
    max = sensor_data.max_by {|x| x.value}
    json.value max.value
    json.created_at max.created_at
  end
else
  json.data [sensor.sensor_data.first]
end
