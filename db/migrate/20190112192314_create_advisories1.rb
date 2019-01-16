class CreateAdvisories1 < ActiveRecord::Migration[5.2]
  def change
    create_table :advisories do |t|
      t.string :recipients, array: true, default: []
      t.string :incoordinate_with, array: true, default: []
      t.references :user, foreign_key: true
      t.string :sid
      t.boolean :is_viewable, default: false
      t.datetime :sent_date
      t.string :advisory_code

      t.timestamps
    end
  end
end
