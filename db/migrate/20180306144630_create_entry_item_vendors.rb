class CreateEntryItemVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_item_vendors do |t|
      t.belongs_to :entry_item , index: true
      t.belongs_to :vendor, index: true

      t.timestamps
    end
  end
end
