class RemoveFieldFromAircraftRegistry < ActiveRecord::Migration[5.2]
  def change
    remove_column :aircraft_registries, :aircraft_type
    remove_column :aircraft_registries, :aircraft_configuration
  end
end
