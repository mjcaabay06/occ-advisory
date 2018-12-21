class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.references :user_department, foreign_key: true
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
