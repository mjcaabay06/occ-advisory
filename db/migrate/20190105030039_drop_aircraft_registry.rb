class DropAircraftRegistry < ActiveRecord::Migration[5.2]
  def change
    drop_table :aircraft_registries
  end
end
