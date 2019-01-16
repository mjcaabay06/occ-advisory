class AddPriorityToInbox < ActiveRecord::Migration[5.2]
  def change
    add_column :inboxes, :priority, :integer
  end
end
