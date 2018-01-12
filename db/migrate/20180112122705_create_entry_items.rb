class CreateEntryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_items do |t|
      t.references :entry, foreign_key: true
      t.references :chart_account, foreign_key: true
      t.decimal :amount
      t.string :dc, limit: 1

      t.timestamps
    end
  end
end
