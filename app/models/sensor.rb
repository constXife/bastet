class Sensor < ActiveRecord::Base
  has_many :sensor_data, -> { order 'created_at desc' }
end