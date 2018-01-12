class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :account, foreign_key: true
      t.integer :entry_type
      t.datetime :date
      t.string :name
      t.string :note
      t.boolean :is_system
      t.boolean :is_reconciled
      t.boolean :is_confirmed
      t.boolean :is_closing
      t.decimal :amount
      t.string :currency_code
      t.datetime :archived_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
