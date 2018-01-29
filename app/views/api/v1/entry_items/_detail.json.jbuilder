json.extract! entry_item, :id, :amount, :dc
json.chart_account do
  json.extract! entry_item.chart_account, :id, :name
end
json.tags entry_item.tags, partial: 'api/v1/tags/detail', as: :tag
