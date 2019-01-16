class CreateAdvisoryReasons < ActiveRecord::Migration[5.2]
  def change
    create_table :advisory_reasons do |t|
      t.string :reasons, array: true, default: []
      t.string :remarks, array: true, default: []
      t.datetime :time_and_date
      t.references :advisory, foreign_key: true

      t.timestamps
    end
  end
end
