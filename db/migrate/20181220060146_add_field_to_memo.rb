class AddFieldToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :aircraft_type, :string
    add_column :memos, :aircraft_configuration, :integer
  end
end
