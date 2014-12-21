FactoryGirl.define do
  factory :sensor_datum do
    value { rand(23.0..32.0) }
    sensor_id 1
    data_type 'temperature'
    created_at { (rand(0..11)).months.ago }
  end
end
