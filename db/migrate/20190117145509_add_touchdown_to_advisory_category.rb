class AddTouchdownToAdvisoryCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :advisory_categories, :touchdown, :time
  end
end
