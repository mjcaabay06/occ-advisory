class AddField4ToMemoCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :memo_categories, :location, :string
    add_column :memo_categories, :movement, :string
    add_column :memo_categories, :max_wind, :string
    add_column :memo_categories, :weather_forecast, :string
    add_column :memo_categories, :route_origin, :string
    add_column :memo_categories, :route_destination, :string
    add_column :memo_categories, :ac_location, :string
  end
end
