class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.references :flight, foreign_key: true
      t.text :weather_condition
      t.text :purpose
      t.text :remarks

      t.timestamps
    end
  end
end
