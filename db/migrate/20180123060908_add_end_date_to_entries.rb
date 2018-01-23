class AddEndDateToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :date_end, :datetime
  end
end
