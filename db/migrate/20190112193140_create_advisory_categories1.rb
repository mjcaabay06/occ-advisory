class CreateAdvisoryCategories1 < ActiveRecord::Migration[5.2]
  def change
    create_table :advisory_categories do |t|
      t.string :ac_configuration
      t.string :ac_location
      t.string :ac_on_ground
      t.string :ac_registry
      t.datetime :ac_status_datetime
      t.string :acu_problem
      t.time :air_bourne
      t.references :aircraft_type, foreign_key: true
      t.string :apu_inoperative
      t.time :baggage_cargo_loaded
      t.time :blocked_in
      t.time :cabin_crew_boarded
      t.references :category, foreign_key: true
      t.time :close_door
      t.time :cockpit_crew_boarded
      t.date :effective_date
      t.date :flight_date
      t.string :flight_number
      t.string :frequencies, array: true, default: []
      t.time :general_boarding
      t.integer :load_b
      t.integer :load_e
      t.integer :load_p
      t.string :location
      t.string :max_wind
      t.string :movement
      t.string :no_avi
      t.time :nsta
      t.time :nstd
      t.time :push_back
      t.text :remarks
      t.string :restriction
      t.string :route_destination
      t.string :route_origin
      t.string :seat_blocks
      t.time :sta
      t.time :std
      t.time :tow_in
      t.time :tow_out
      t.string :weather_forecast
      t.string :arrival_terminal
      t.string :departure_terminal
      t.time :duration_of_delay
      t.time :eta
      t.time :etd
      t.time :neta
      t.time :netd
      t.string :pax
      t.references :advisory_reason, foreign_key: true

      t.timestamps
    end
  end
end
