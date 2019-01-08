class CreateAircraftTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :aircraft_types do |t|
      t.string :ac_type
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
