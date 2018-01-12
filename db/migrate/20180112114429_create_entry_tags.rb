class CreateEntryTags < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_tags do |t|
      t.belongs_to :entry, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
