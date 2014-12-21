class CreateSensor < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.string :name, nullable: true
      t.string :sid
      t.timestamps null: false
    end
  end
end