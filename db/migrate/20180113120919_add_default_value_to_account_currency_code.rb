class AddDefaultValueToAccountCurrencyCode < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :default_country_code, :string, default: "USD"
  end
end
