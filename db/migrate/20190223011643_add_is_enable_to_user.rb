class AddIsEnableToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_enable, :boolean, default: true
  end
end
