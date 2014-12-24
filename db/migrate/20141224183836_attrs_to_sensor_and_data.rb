class AttrsToSensorAndData < ActiveRecord::Migration
  def change
    change_table :sensors do |t|
      t.change :sid, :string, null: false
    end

    change_table :sensor_data do |t|
      t.change :data_type,  :string,  null: false
      t.change :value,      :float,   null: false
      t.change :raw_data,   :jsonb,   null: false
      t.change :sensor_id,  :integer, null: false
    end
  end
end
