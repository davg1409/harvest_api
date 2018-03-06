class EntryItemCustomer < ApplicationRecord
    belongs_to :customer
    belongs_to :entry_item
end
