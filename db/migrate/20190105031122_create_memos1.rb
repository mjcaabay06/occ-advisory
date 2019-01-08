class CreateMemos1 < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.string :recipients, array: true, default: []
      t.string :incoordinate_with, array: true, default: []
      t.string :reasons, array: true, default: []
      t.string :remarks, array: true, default: []

      t.timestamps
    end
  end
end
