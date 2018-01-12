class Entry < ApplicationRecord
  belongs_to :account

  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags
  has_many :entry_items, dependent: :destroy

  enum entry_type: [:check]

  accepts_nested_attributes_for :entry_items

  validates_presence_of :account, :entry_type, :name, :date, :amount
  validates_uniqueness_of :name, scope: :account_id
end
