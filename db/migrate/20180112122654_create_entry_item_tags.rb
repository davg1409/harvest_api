class CreateEntryItemTags < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_item_tags do |t|
      t.belongs_to :entry_item , index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
