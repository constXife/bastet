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

FactoryGirl.define do
  factory :sensor do
    name { Faker::Name.name if [0,1].sample }
    sid { Faker::Name.name }
  end
end
