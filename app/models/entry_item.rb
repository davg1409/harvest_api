class EntryItem < ApplicationRecord
  belongs_to :entry
  belongs_to :chart_account

  has_many :entry_item_tags, dependent: :destroy
  has_many :tags, through: :entry_item_tags

  validates_presence_of :dc, :chart_account, :amount
  validates_inclusion_of :dc, in: %w(d c)

  before_save :update_chart_account_balance!
  
  delegate :is_confirmed, to: :entry, prefix: true

  def debit?
    self.dc == "d"
  end

  def credit?
    self.dc == "c"
  end

  private
    def update_chart_account_balance!
      if self.entry_is_confirmed
        
        if self.new_record?
          self.debit? ? self.chart_account.increase_balance!(self.amount) : self.chart_account.decrease_balance!(self.amount)
        elsif self.amount_changed? && self.dc_changed? && self.amount_was != nil && self.dc_was != nil
          self.dc_was == "d" ? self.chart_account.decrease_balance!(self.amount_was) : self.chart_account.increase_balance!(self.amount_was)        
          self.debit? ? self.chart_account.increase_balance!(self.amount) : self.chart_account.decrease_balance!(self.amount)
        elsif self.amount_changed? && self.amount_was != nil
          self.debit? ? self.chart_account.decrease_balance!(self.amount_was) : self.chart_account.increase_balance!(self.amount_was)
          self.debit? ? self.chart_account.increase_balance!(self.amount) : self.chart_account.decrease_balance!(self.amount)
        elsif self.dc_changed? && self.dc_was != nil
          self.dc_was == "d" ? self.chart_account.decrease_balance!(self.amount_was) : self.chart_account.increase_balance!(self.amount_was)
          self.debit? ? self.chart_account.increase_balance!(self.amount) : self.chart_account.decrease_balance!(self.amount)
        end
      end
    end
end


