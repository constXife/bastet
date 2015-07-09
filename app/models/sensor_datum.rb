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

class SensorDatum < ActiveRecord::Base
  belongs_to :sensor

  validates :value, :sensor_id, :data_type, :raw_data, presence: true

  default_scope { order('created_at DESC') }

  scope :daily, -> (*) do
    where('created_at > ? AND created_at < ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end
end
