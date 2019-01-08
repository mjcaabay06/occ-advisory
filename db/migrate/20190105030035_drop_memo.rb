class DropMemo < ActiveRecord::Migration[5.2]
  def change
    drop_table :loads
    drop_table :memos
  end
end
