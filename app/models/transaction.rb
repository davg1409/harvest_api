class Transaction < ApplicationRecord
  belongs_to :account

  enum entry_type: [:check, :deposit, :expense, :transfer]

  validates_presence_of :account, :entry_type, :name, :date, :amount
  validates_uniqueness_of :name, scope: :account_id
end