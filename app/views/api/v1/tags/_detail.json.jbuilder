json.extract! tag, :id, :name
json.tag_kind do
  json.partial! "/api/v1/tag_kinds/detail", tag_kind: tag.tag_kind if tag.tag_kind.present?
end