class ChangeBooleanDefaultToEntries < ActiveRecord::Migration[5.1]
  def change
    change_column_default :entries, :is_system, false
    change_column_default :entries, :is_reconciled, false
    change_column_default :entries, :is_confirmed, false
    change_column_default :entries, :is_closing, false
    change_column_default :entries, :currency_code, 'USD'
  end
end
