class Account < ActiveRecord::Base
  validates_presence_of :name

  has_many :chart_accounts
  has_many :tags
  has_many :entries
  has_many :transactions
  has_one :user

  after_create :create_default_chart_accounts!

  protected
    def create_default_chart_accounts!
      ChartAccount.create_defaults_for self.id
    end
end
