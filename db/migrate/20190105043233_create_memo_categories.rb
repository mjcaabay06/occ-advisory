class CreateMemoCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :memo_categories do |t|
      t.references :memo, foreign_key: true
      t.time :tow_out
      t.time :tow_in
      t.time :blocked_in
      t.string :ac_registry
      t.time :cockpit_crew_boarded
      t.time :cabin_crew_boarded
      t.time :general_boarding
      t.time :baggage_cargo_loaded
      t.time :close_door
      t.time :push_back
      t.time :air_bourne
      t.text :remarks

      t.timestamps
    end
  end
end
