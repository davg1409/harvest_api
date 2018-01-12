json.extract! entry, :id, :name, :date, :amount, :currency_code, :account_id
json.items entry.entry_items, partial: 'api/v1/entry_items/detail', as: :entry_item
