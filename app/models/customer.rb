class Customer < ApplicationRecord
    belongs_to :account, optional: true

    has_many :entry_customers
    has_many :entries, through: :entry_customers
    has_many :entry_item_customers
    has_many :entry_items, through: :entry_item_customers

    validates_presence_of :name
end
