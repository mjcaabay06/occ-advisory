class CreateLoads < ActiveRecord::Migration[5.2]
  def change
    create_table :loads do |t|
      t.integer :seat_number
      t.string :specific_cabin

      t.timestamps
    end
  end
end
