class Account < ActiveRecord::Base
  validates_presence_of :name

  has_many :chart_accounts
  has_many :tags
  has_many :entries
  has_one :user
end
