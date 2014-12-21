class CreateSensorData < ActiveRecord::Migration
  def change
    create_table :sensor_data do |t|
      t.float       :value
      t.belongs_to  :sensor
      t.string      :data_type
      t.datetime    :data_date, nullable: true
      t.jsonb       :raw_data
      t.timestamps  null: false
    end
  end
end
