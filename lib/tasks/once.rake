namespace :once do
  desc "Update child of other expense records"
  task update_other_expense_chart_accounts: :environment do
    ChartAccount.where(name: ["Interest Expense", "Loss on Asset Disposal"]).includes(:account).each do |ca|
      other_expense = ca.account.chart_accounts.find_by name: "Other Expenses"

      ca.update parent_id: other_expense.id if other_expense.present?
      puts "================ Updated parent to other expense for chart account #{ca.name}"
    end
  end
end