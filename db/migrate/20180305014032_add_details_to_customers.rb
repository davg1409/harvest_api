class AddDetailsToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :title, :string
    add_column :customers, :first_name, :string
    add_column :customers, :middle_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :suffix, :string
    add_column :customers, :company, :string
    add_column :customers, :display_name, :string
    add_column :customers, :print_name, :string
    add_column :customers, :street, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :zipcode, :string
    add_column :customers, :country, :string
    add_column :customers, :notes, :string
    add_column :customers, :email, :string
    add_column :customers, :phone, :string
    add_column :customers, :mobile, :string
    add_column :customers, :fax, :string
    add_column :customers, :other, :string
    add_column :customers, :website, :string
    add_column :customers, :terms, :string
    add_column :customers, :opening_balance, :string
    add_column :customers, :opening_balance_date, :datetime
    add_column :customers, :account_number, :string
    add_column :customers, :business_id, :string
    add_column :customers, :track_payments, :boolean
  end
end
