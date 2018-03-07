class AddDetailsToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :vendor_id, :string
    add_column :entries, :customer_id, :string
  end
end
