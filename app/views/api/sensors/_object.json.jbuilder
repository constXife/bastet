json.(sensor, :id,
              :sid)
json.name sensor.to_s
if defined? sensor_data
  json.data sensor_data
  json.average sensor_data.map(&:value).inject(0, &:+)/sensor_data.length
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
