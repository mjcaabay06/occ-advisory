class AddFieldsToMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :memos, :flight_monitoring, :datetime
    add_column :memos, :aircraft_on_ground, :string
    add_column :memos, :status, :string
    add_column :memos, :aircraft_inoperative, :string
    add_column :memos, :seat_block, :string
    add_column :memos, :no_avi, :string
    add_column :memos, :restriction, :text
    add_column :memos, :airconditioning, :string
  end
end
