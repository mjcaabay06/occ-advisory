class CreateRemarks < ActiveRecord::Migration[5.2]
  def change
    create_table :remarks do |t|
      t.text :remark
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
