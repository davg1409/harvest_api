class AddAccountIdToChartAccounts < ActiveRecord::Migration[5.1]
  def change
    add_reference :chart_accounts, :account, foreign_key: true
  end
end
