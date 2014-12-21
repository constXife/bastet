json.(sensor, :id,
              :name,
              :sid)
if defined? sensor_data
  json.data sensor_data
else
  json.data [sensor.sensor_data.first]
end
