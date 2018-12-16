class CreatePageActions < ActiveRecord::Migration[5.2]
  def change
    create_table :page_actions do |t|
      t.string :description
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
