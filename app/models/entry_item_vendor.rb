class EntryItemVendor < ApplicationRecord
    belongs_to :vendor
    belongs_to :entry_item
end
