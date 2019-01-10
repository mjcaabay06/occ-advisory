class AddMemoToAdvisory < ActiveRecord::Migration[5.2]
  def change
    add_reference :advisories, :memo, foreign_key: true
  end
end
