class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.references :entry, foreign_key: true
      t.string :document

      t.timestamps
    end
  end
end
