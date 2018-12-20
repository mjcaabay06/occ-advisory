class AddMemoToLoad < ActiveRecord::Migration[5.2]
  def change
    add_reference :loads, :memo, foreign_key: true
  end
end
