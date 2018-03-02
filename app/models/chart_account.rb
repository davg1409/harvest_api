class ChartAccount < ApplicationRecord
  belongs_to :parent, class_name: "ChartAccount", optional: true
  belongs_to :classification, class_name: "ChartAccountClassification", optional: true

  belongs_to :account, optional: true
  has_many :chart_accounts, foreign_key: :parent_id

  has_many :entry_items
  has_many :entries, through: :entry_items

  validates_presence_of :name, :account
  validates_uniqueness_of :name, scope: :account_id

  before_create :inherit_from_parent
  after_destroy :update_parent_for_children!

  class << self
    def create_defaults_for account_id
      asset = ChartAccount.create name: "Assets", classification_id: 1, editable: false, deletable: false, account_id: account_id
      liabilities = ChartAccount.create name: "Liabilities", classification_id: 11, editable: false, deletable: false, account_id: account_id
      equity = ChartAccount.create name: "Equity", classification_id: 17, editable: false, deletable: false, account_id: account_id
      sales = ChartAccount.create name: "Sales", classification_id: 20, editable: true, deletable: false, account_id: account_id
      other_revenue = ChartAccount.create name: "Other Revenue", classification_id: 21, editable: true, deletable: false, account_id: account_id
      goods_sold = ChartAccount.create name: "Cost of Goods Sold", classification_id: 22, editable: true, deletable: false, account_id: account_id
      expenses = ChartAccount.create name: "Expenses", classification_id: 23, editable: true, deletable: false, account_id: account_id
      other_expenses = ChartAccount.create name: "Other Expenses", classification_id: 25, editable: true, deletable: false, account_id: account_id
      ask_my_accountant = ChartAccount.create name: "Ask My Accountant", classification_id: 27, editable: true, deletable: false, account_id: account_id

      current_asset = asset.chart_accounts.create(name: "Current Assets", classification_id: 2, editable: true, deletable: false, account_id: account_id)
      fixed_asset = asset.chart_accounts.create(name: "Fixed Assets", classification_id: 8, editable: true, deletable: false, account_id: account_id)
      other_asset = asset.chart_accounts.create(name: "Other Assets", classification_id: 9, editable: true, deletable: false, account_id: account_id)
      long_term_investment = asset.chart_accounts.create(name: "Long-Term Investments", classification_id: 10, editable: true, deletable: false, account_id: account_id)
      cash = current_asset.chart_accounts.create(name: "Cash", classification_id: 3, editable: true, deletable: false, account_id: account_id)
        
      current_asset.chart_accounts.create([{
          "name": "Accounts Receivable",
          "classification_id": 5,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        },
        {
          "name": "Inventory",
          "classification_id": 6,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        },
        {
          "name": "Prepaid Expenses",
          "classification_id": 7,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        },
        {
          "name": "In Transit",
          "classification_id": 26,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        }
      ])

      fixed_asset.chart_accounts.create([{
          "name": "Equipment",
          "classification_id": 8,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Furniture & Fixtures",
          "classification_id": 8,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Supplies",
          "classification_id": 8,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Property",
          "classification_id": 8,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])

      cash.chart_accounts.create([{
          "name": "Harvest Merchant Account",
          "classification_id": 4,
          "editable": false,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Short-Term Investments",
          "classification_id": 3,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        }
      ])

      current_liabilities = liabilities.chart_accounts.create(name: "Current Liabilities", classification_id: 12, editable: true, deletable: false, account_id: account_id)
      long_term_liabilities = liabilities.chart_accounts.create(name: "Long-Term Liabilities", classification_id: 16, editable: true, deletable: false, account_id: account_id)
      credit_account = current_liabilities.chart_accounts.create(name: "Credit Accounts", classification_id: 13, editable: true, deletable: false, account_id: account_id)
      account_payable = current_liabilities.chart_accounts.create(name: "Accounts Payable", classification_id: 14, editable: true, deletable: false, account_id: account_id)
      unearned_revenue = current_liabilities.chart_accounts.create(name: "Unearned Revenue", classification_id: 15, editable: true, deletable: false, account_id: account_id)
        
      account_payable.chart_accounts.create([{
          "name": "Payroll Payable",
          "classification_id": 14,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Income Tax Payable",
          "classification_id": 14,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Property Tax Payable",
          "classification_id": 14,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },   
        {
          "name": "Insurance Payable",
          "classification_id": 14,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
  
      equity.chart_accounts.create([{
          "name": "Invested Capital",
          "classification_id": 18,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        },
        {
          "name": "Owner Distribution",
          "classification_id": 17,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        },
        {
          "name": "Retained Earnings",
          "classification_id": 19,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        }
      ])
    
      sales.chart_accounts.create([{
          "name": "Product Sales",
          "classification_id": 20,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        },
        {
          "name": "Service Sales",
          "classification_id": 20,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        }
      ])

      other_revenue.chart_accounts.create([{
          "name": "Interest Income",
          "classification_id": 21,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Gain on Asset Disposal",
          "classification_id": 21,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])

      office_expense = expenses.chart_accounts.create({
          "name": "Office Expenses",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
      })
      insurance = expenses.chart_accounts.create({
        "name": "Insurance",
        "classification_id": 23,
        "editable": true,
        "deletable": true,
        "account_id": account_id
      })
      sales_wages = expenses.chart_accounts.create({
        "name": "Salaries & Wages",
        "classification_id": 23,
        "editable": true,
        "deletable": true,
        "account_id": account_id
      })
      taxes = expenses.chart_accounts.create({
          "name": "Taxes",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        })
      vehicle_expense = expenses.chart_accounts.create({
          "name": "Vehicle Expenses",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        })
      expenses.chart_accounts.create([{
          "name": "Advertising",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Marketing",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Software & Subscriptions",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Employee Benefits",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Accounting Services",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Legal Services",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Meals & Entertainment",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Travel",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Depreciation Expense",
          "classification_id": 24,
          "editable": true,
          "deletable": false,
          "account_id": account_id
        }
      ])
  
      office_expense.chart_accounts.create([{
          "name": "Rent",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Utilities",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Supplies",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Telephone & Communications",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Printing & Postage",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
  
      insurance.chart_accounts.create([{
          "name": "Health or Medical Insurance",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Dental Insurance",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Life Insurance",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Car or Auto Insurance",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Liability Insurance",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Business Insurance",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
  
      sales_wages.chart_accounts.create([{
          "name": "Employee Salaries & Wages",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Contractor Salaries & Wages",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
    
      taxes.chart_accounts.create([{
          "name": "Business License",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Property Taxes",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Income Taxes",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
  
      vehicle_expense.chart_accounts.create([{
          "name": "Maintenance & Repair",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Lease",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Fuel or Gas",
          "classification_id": 23,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
  
      other_expenses.chart_accounts.create([{
          "name": "Interest Expense",
          "classification_id": 25,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        },
        {
          "name": "Loss on Asset Disposal",
          "classification_id": 25,
          "editable": true,
          "deletable": true,
          "account_id": account_id
        }
      ])
    end
  end

  def increase_balance! amt
    self.update_attribute :balance, ((self.balance || 0.0) + amt)
  end

  def decrease_balance! amt
    self.update_attribute :balance, ((self.balance || 0.0) - amt)
  end

  protected
    def inherit_from_parent
      if self.parent.present?
        self.classification_id = self.parent.classification_id
        self.dc = self.parent.dc
      end
    end

    def update_parent_for_children!
      self.chart_accounts.update_all parent_id: self.parent_id
    end
end
