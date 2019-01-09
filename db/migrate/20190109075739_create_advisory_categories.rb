class CreateAdvisoryCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :advisory_categories do |t|
      t.references :advisory, foreign_key: true

      t.timestamps
    end
  end
end
