class CreateUserPageActions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_page_actions do |t|
      t.references :user, foreign_key: true
      t.string :page_actions

      t.timestamps
    end
  end
end
