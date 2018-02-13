class UpdateBalanceOnChartAccount < ActiveRecord::Migration[5.1]
  def up
    change_column :entry_items, :amount, :decimal, default: 0.00
    change_column :chart_accounts, :balance, :decimal, default: 0.00
  end

  def down
    change_column :chart_accounts, :balance, :decimal
    change_column :entry_items, :amount, :decimal
  end
end
