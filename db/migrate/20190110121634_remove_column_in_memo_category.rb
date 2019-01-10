class RemoveColumnInMemoCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :memo_categories, :frequency_id
    add_column :memo_categories, :frequencies, :string, array: true, default: []
  end
end
