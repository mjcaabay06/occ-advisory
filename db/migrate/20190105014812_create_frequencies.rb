class CreateFrequencies < ActiveRecord::Migration[5.2]
  def change
    create_table :frequencies do |t|
      t.string :frequency
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
