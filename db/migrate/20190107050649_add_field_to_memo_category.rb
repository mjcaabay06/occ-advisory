class AddFieldToMemoCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :memo_categories, :category, foreign_key: true
    add_column :memo_categories, :effective_date, :date
    add_column :memo_categories, :ac_status_date, :date
    add_column :memo_categories, :flight_number, :string
  end
end
