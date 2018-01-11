json.extract! chart_account, :id, :name, :code, :editable, :deletable, :dc, :balance
json.parent do
  json.extract! chart_account.parent, :id, :name if chart_account.parent.present?
end

json.classification do
  json.extract! chart_account.classification, :id, :name if chart_account.classification.present?
end