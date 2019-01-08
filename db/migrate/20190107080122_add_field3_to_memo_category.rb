class AddField3ToMemoCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :memo_categories, :load_b, :integer
    add_column :memo_categories, :load_p, :integer
    add_column :memo_categories, :load_e, :integer
  end
end
