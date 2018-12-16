class AddCodeToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :code, :string
  end
end
