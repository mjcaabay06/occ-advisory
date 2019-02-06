class AddCategoryFieldsToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :category_fields, :string, array: true, default: []
  end
end
