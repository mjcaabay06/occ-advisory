class AddAdvisoryCategoryFieldsToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :advisory_category_fields, :string, array: true, default: []
  end
end
