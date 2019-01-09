class AddIsViewableToAdvisory < ActiveRecord::Migration[5.2]
  def change
    add_column :advisories, :is_viewable, :boolean, default: false
  end
end
