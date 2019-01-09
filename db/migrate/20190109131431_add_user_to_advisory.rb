class AddUserToAdvisory < ActiveRecord::Migration[5.2]
  def change
    add_reference :advisories, :user, foreign_key: true
  end
end
