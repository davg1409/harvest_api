class Tag < ActiveRecord::Base
  belongs_to :tag_kind
  belongs_to :account, optional: true
  
  has_many :entry_tags
  has_many :entries, through: :entry_tags
  has_many :entry_item_tags
  has_many :entry_items, through: :entry_item_tags

  validates_presence_of :name, :tag_kind, :account
  validates_uniqueness_of :name, scope: :account_id
end
