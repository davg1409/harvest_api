class Account < ActiveRecord::Base
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :chart_accounts
  has_many :tags
  has_one :user
end
