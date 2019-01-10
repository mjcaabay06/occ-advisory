class AddSentDateToAdvisory < ActiveRecord::Migration[5.2]
  def change
    add_column :advisories, :sent_date, :datetime
  end
end
