class AddDefaultValueToIsConfirmed < ActiveRecord::Migration[5.1]
  def change
    change_column :entries, :is_confirmed, :boolean, default: true
  end
end
