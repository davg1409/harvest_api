# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.connection.execute "TRUNCATE chart_account_classifications RESTART IDENTITY"
names = ["Assets", "Current Assets", "Cash", "Harvest Merchant Account", "Accounts Receivable", "Inventory", "Prepaid Expenses", "Fixed Assets", "Other Assets", "Long-Term Investments", "Liabilities", "Current Liabilities", "Credit Accounts", "Accounts Payable", "Unearned Revenue", "Long-Term Liabilities", "Equity", "Invested Capital", "Retained Earnings", "Sales", "Other Revenue", "Cost of Goods Sold", "Operating Expenses", "Depreciation Expense", "Other Expenses", "In Transit", "Suspense"]

chart_account_classifications = ChartAccountClassification.create(names.map { |name| { name: name } })