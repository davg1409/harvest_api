class ChangeColumnInChartAccount < ActiveRecord::Migration[5.1]
  def change
    change_column :chart_accounts, :editable, :boolean, default: true
    change_column :chart_accounts, :deletable, :boolean, default: true
    change_column :chart_accounts, :balance, :decimal, scale: 2, precision: 10, default: 0

    ChartAccountClassification.create(%w(Assets Sales).map { |name| { name: name } })
  end
end
