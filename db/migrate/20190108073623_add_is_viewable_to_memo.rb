class AddIsViewableToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :is_viewable, :boolean, default: false
  end
end
