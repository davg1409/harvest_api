class CreateTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.integer :entry_type
      t.datetime :date
      t.string :name
      t.string :note
      t.boolean :is_system, default: false
      t.boolean :is_reconciled, default: false
      t.boolean :is_confirmed, default: false
      t.boolean :is_closing, default: false
      t.decimal :amount, default: 0.0, scale: 2, precision: 10
      t.string :currency_code, default: "USD"

      t.timestamps
    end
  end
end
