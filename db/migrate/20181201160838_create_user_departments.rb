class CreateUserDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_departments do |t|
      t.string :description
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
