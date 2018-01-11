class CreateChartAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :chart_accounts do |t|
      t.integer :parent_id
      t.integer :classification_id
      t.string :name
      t.integer :code
      t.boolean :editable, default: false
      t.boolean :deletable, default: false
      t.decimal :balance, scale: 2, precision: 10
      t.string :dc, limit: 1

      t.timestamps
    end
  end
end
