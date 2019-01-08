class RemoveAcStatusDateFromMemoCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :memo_categories, :ac_status_date
  end
end
