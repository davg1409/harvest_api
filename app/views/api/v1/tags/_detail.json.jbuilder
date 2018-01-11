json.extract! tag, :id, :name, :account_id
json.tag_kind do
  json.partial! "/api/v1/tag_kinds/detail", tag_kind: tag.tag_kind if tag.tag_kind.present?
end