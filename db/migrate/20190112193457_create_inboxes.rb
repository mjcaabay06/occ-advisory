class CreateInboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :inboxes do |t|
      t.integer :recipient
      t.integer :sender
      t.references :advisory, foreign_key: true
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
