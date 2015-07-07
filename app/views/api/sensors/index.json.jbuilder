json.sensors do
  json.array! @sensors, partial: 'object', as: :sensor
end
