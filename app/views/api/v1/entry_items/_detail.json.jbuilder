json.extract! entry_item, :id, :amount, :dc, :chart_account_id
json.tags entry_item.tags, partial: 'api/v1/tags/detail', as: :tag
