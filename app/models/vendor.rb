class Vendor < ApplicationRecord
    belongs_to :account, optional: true

    has_many :entry_vendors
    has_many :entries, through: :entry_vendors
    has_many :entry_item_vendors
    has_many :entry_items, through: :entry_item_vendors
    
    validates_presence_of :name
end
