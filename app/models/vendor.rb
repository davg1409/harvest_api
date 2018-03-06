class Vendor < ApplicationRecord
    belongs_to :account, optional: true

    validates_presence_of :name
end
