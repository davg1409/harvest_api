class CreateEntryCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_customers do |t|
      t.belongs_to :entry, index: true
      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
