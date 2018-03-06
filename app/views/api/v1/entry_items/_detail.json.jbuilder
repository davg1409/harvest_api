json.extract! entry_item, :id, :amount, :dc
json.chart_account do
  json.extract! entry_item.chart_account, :id, :name
end
json.tags entry_item.tags, partial: 'api/v1/tags/detail', as: :tag
json.customers entry_item.customers, partial: 'api/v1/customers/detail', as: :customer
json.vendors entry_item.vendors, partial: 'api/v1/vendors/detail', as: :vendor
