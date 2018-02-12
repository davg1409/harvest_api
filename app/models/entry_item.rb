class EntryItem < ApplicationRecord
  belongs_to :entry
  belongs_to :chart_account

  has_many :entry_item_tags, dependent: :destroy
  has_many :tags, through: :entry_item_tags

  validates_presence_of :dc, :chart_account, :amount
  validates_inclusion_of :dc, in: %w(d c)

  after_save :update_chart_account_balance!
  
  def debit?
    self.dc == "d"
  end

  def credit?
    self.dc == "c"
  end

  private
    def update_chart_account_balance!
      if self.new_record? || (self.dc_changed? || self.amount_changed?)
        self.debit? ? self.chart_account.increase_balance!(self.amount) : self.chart_account.decrease_balance!(self.amount)
      end
    end
end
