class AddAcStatusDateTimeToMemoCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :memo_categories, :ac_status_datetime, :datetime
  end
end
