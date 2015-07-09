# == Schema Information
#
# Table name: sensors
#
#  id         :integer          not null, primary key
#  name       :string
#  sid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Sensor do
  describe '#to_s' do
    it 'is name' do
      sensor = Sensor.new(name: 'test', sid: 'sid')
      expect(sensor.to_s).to eq('test')
    end

    it 'is sid' do
      sensor = Sensor.new(sid: 'sid')
      expect(sensor.to_s).to eq('sid')
    end
  end

  describe '#status' do
    it 'is ok' do
      sensor = FactoryGirl.build(:sensor)
      sensor_datum = FactoryGirl.build(:sensor_datum, created_at: Time.now)
      sensor.sensor_data << sensor_datum
      expect(sensor.status).to eq('ok')
    end

    it 'is fail' do
      sensor = FactoryGirl.build(:sensor)
      sensor_datum = FactoryGirl.build(:sensor_datum, created_at: 1.day.ago)
      sensor.sensor_data << sensor_datum
      expect(sensor.status).to eq('fail')
    end
  end
end
