json.extract! entry, :id, :name, :date, :date_end, :amount, :currency_code, :account_id, :vendor_id, :customer_id, :entry_type, :is_system, :is_reconciled, :is_confirmed, :is_closing, :note
json.items entry.entry_items, partial: 'api/v1/entry_items/detail', as: :entry_item
json.attachments entry.attachments, partial: 'api/v1/attachments/detail', as: :attachment
json.tags entry.tags, partial: 'api/v1/tags/detail', as: :tag