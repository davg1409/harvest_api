class EntryItemTag < ApplicationRecord
  belongs_to :tag
  belongs_to :entry_item
end
