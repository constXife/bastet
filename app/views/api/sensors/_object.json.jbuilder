json.(sensor, :id,
              :sid)
json.name sensor.to_s
if defined? sensor_data
  json.data sensor_data
else
  json.data [sensor.sensor_data.first]
end
