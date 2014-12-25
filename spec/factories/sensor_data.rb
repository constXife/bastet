# == Schema Information
#
# Table name: sensor_data
#
#  id         :integer          not null, primary key
#  value      :float            not null
#  sensor_id  :integer          not null
#  data_type  :string           not null
#  data_date  :datetime
#  raw_data   :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :sensor_datum do
    value { rand(23.0..32.0) }
    sensor_id 1
    data_type 'temperature'
    created_at { (rand(0..11)).months.ago }
  end
end
