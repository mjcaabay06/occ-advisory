class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.references :aircraft_registry, foreign_key: true
      t.string :flight_number
      t.date :flight_date
      t.date :international_flight_date
      t.datetime :monitoring_update
      t.text :route
      t.integer :std
      t.integer :sta
      t.integer :frequency
      t.time :tow_in
      t.time :tow_out
      t.time :block_in
      t.time :cockpit_crew_boarding
      t.time :cabin_crew_boarding
      t.time :general_boarding
      t.time :cargo_boarding
      t.string :aircraft_status
      t.string :cabin_crew_availablity
      t.text :weather_condition
      t.text :purpose
      t.text :remarks

      t.timestamps
    end
  end
end
