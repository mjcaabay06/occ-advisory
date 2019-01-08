class AddField6ToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :memo_code, :string
    add_column :memos, :sid, :string
  end
end
