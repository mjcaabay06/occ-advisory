class CreateAircraftRegistries < ActiveRecord::Migration[5.2]
  def change
    create_table :aircraft_registries do |t|
      t.string :aircraft_name
      t.integer :max_seat
      t.integer :max_cabin
      t.string :aircraft_type
      t.string :aircraft_configuration

      t.timestamps
    end
  end
end
