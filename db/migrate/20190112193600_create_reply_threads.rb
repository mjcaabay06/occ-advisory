class CreateReplyThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :reply_threads do |t|
      t.text :message
      t.references :user, foreign_key: true
      t.references :advisory, foreign_key: true

      t.timestamps
    end
  end
end
