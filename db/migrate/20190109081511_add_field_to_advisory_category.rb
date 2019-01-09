class AddFieldToAdvisoryCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :advisory_categories, :flight_date, :date
    add_column :advisory_categories, :flight_number, :string
    add_column :advisory_categories, :route_origin, :string
    add_column :advisory_categories, :route_destination, :string
    add_column :advisory_categories, :ac_registry, :string
    add_reference :advisory_categories, :aircraft_type, foreign_key: true
    add_column :advisory_categories, :ac_configuration, :string
    add_column :advisory_categories, :remarks, :text
    add_column :advisory_categories, :pax, :string
    add_column :advisory_categories, :etd, :time
    add_column :advisory_categories, :eta, :time
    add_column :advisory_categories, :netd, :time
    add_column :advisory_categories, :neta, :time
    add_column :advisory_categories, :duration_of_delay, :time
    add_column :advisory_categories, :departure_terminal, :string
    add_column :advisory_categories, :arrival_terminal, :string
    add_reference :advisory_categories, :category, foreign_key: true
  end
end
