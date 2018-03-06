class EntryVendor < ApplicationRecord
    belongs_to :entry
    belongs_to :vendor
end
