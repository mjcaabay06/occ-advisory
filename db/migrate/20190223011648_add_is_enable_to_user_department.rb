class AddIsEnableToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :is_enable, :boolean, default: true
  end
end
