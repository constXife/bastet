class SensorDatum < ActiveRecord::Base
  belongs_to :sensor

  default_scope { order('created_at DESC') }

  scope :daily, -> (*) do
    where('created_at > ? AND created_at < ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      .group('id', "DATE_PART('hour', created_at)")
      .limit(1440)
  end
end
