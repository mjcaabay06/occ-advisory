class AddTimeAndDateToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :time_and_date, :datetime
  end
end
