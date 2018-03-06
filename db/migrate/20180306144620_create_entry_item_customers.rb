class CreateEntryItemCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_item_customers do |t|
      t.belongs_to :entry_item , index: true
      t.belongs_to :customer, index: true
      
      t.timestamps
    end
  end
end
