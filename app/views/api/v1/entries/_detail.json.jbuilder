json.extract! entry, :id, :name, :date, :amount, :currency_code, :account_id, :entry_type
json.items entry.entry_items, partial: 'api/v1/entry_items/detail', as: :entry_item
json.attachments entry.attachments, partial: 'api/v1/attachments/detail', as: :attachment
