class AddField2ToMemoCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :memo_categories, :apu_inoperative, :string
    add_column :memo_categories, :seat_blocks, :string
    add_column :memo_categories, :no_avi, :string
    add_column :memo_categories, :restriction, :string
    add_column :memo_categories, :acu_problem, :string
    add_column :memo_categories, :ac_on_ground, :string
  end
end
