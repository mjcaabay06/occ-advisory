class AddSentDateToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :sent_date, :datetime
  end
end
