class AddFieldsToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :reason_options, :string, array: true, default: []
    add_column :user_departments, :remark_options, :string, array: true, default: []
  end
end
