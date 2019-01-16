class DropTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :advisory_categories
    drop_table :advisories
    drop_table :memo_categories
    drop_table :memos
  end
end
