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

require 'rails_helper'

RSpec.describe SensorDatum do
  it 'gets daily reports' do
    FactoryGirl.create(:sensor_datum, created_at: Time.now)
    FactoryGirl.create(:sensor_datum, created_at: 1.day.ago)

    expect(SensorDatum.daily.count).to eq(1)
  end
end
