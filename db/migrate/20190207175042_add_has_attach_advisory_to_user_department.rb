class AddHasAttachAdvisoryToUserDepartment < ActiveRecord::Migration[5.2]
  def change
    add_column :user_departments, :has_attach_advisory, :boolean, default: false
  end
end
