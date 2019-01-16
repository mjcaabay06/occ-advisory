class CreateAdvisoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :advisory_relations do |t|
      t.integer :dept_advisory
      t.integer :occ_advisory
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
