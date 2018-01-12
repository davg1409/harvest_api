class Tag < ActiveRecord::Base
  belongs_to :tag_kind
  belongs_to :account, optional: true
  
  validates_presence_of :name, :tag_kind, :account
  validates_uniqueness_of :name, scope: :account_id
end
