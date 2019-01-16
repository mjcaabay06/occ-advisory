class AddOtherRemarksToAdvisoryReason < ActiveRecord::Migration[5.2]
  def change
    add_column :advisory_reasons, :other_remarks, :text
  end
end
