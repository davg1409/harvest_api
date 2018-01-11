class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :country
      t.string :state
      t.string :city
      t.text :address
      t.integer :phone
      t.column :default_country_code, "char(2)"

      t.timestamps
    end
  end
end
