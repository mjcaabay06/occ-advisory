class AddHasTimeAndDateToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :has_time_and_date, :boolean, default: false
  end
end
