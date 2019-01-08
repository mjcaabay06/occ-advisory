class AddFields5ToMemoCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :memo_categories, :flight_date, :date
    add_reference :memo_categories, :aircraft_type, foreign_key: true
    add_column :memo_categories, :ac_configuration, :string
    add_column :memo_categories, :std, :time
    add_column :memo_categories, :sta, :time
    add_reference :memo_categories, :frequency, foreign_key: true
    add_column :memo_categories, :nstd, :time
    add_column :memo_categories, :nsta, :time
  end
end
