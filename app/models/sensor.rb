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

class Sensor < ActiveRecord::Base
  has_many :sensor_data, -> { order 'created_at desc' }

  validates :sid, presence: true

  def to_s
    name || sid
  end

  def status
    if sensor_data.last.created_at > 1.day.ago
      'ok'
    else
      'fail'
    end
  end
end
