class AddDetailsToVendors < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :title, :string
    add_column :vendors, :first_name, :string
    add_column :vendors, :middle_name, :string
    add_column :vendors, :last_name, :string
    add_column :vendors, :suffix, :string
    add_column :vendors, :company, :string
    add_column :vendors, :display_name, :string
    add_column :vendors, :print_name, :string
    add_column :vendors, :street, :string
    add_column :vendors, :city, :string
    add_column :vendors, :state, :string
    add_column :vendors, :zipcode, :string
    add_column :vendors, :country, :string
    add_column :vendors, :notes, :string
    add_column :vendors, :email, :string
    add_column :vendors, :phone, :string
    add_column :vendors, :mobile, :string
    add_column :vendors, :fax, :string
    add_column :vendors, :other, :string
    add_column :vendors, :website, :string
    add_column :vendors, :terms, :string
    add_column :vendors, :opening_balance, :string
    add_column :vendors, :opening_balance_date, :datetime
    add_column :vendors, :account_number, :string
    add_column :vendors, :business_id, :string
    add_column :vendors, :track_payments, :boolean
  end
end
