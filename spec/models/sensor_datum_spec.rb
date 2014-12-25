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

RSpec.describe SensorDatum, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
