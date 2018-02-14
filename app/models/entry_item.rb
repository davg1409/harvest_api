class EntryItem < ApplicationRecord
  belongs_to :entry
  belongs_to :chart_account

  has_many :entry_item_tags, dependent: :destroy
  has_many :tags, through: :entry_item_tags

  validates_presence_of :dc, :chart_account, :amount
  validates_inclusion_of :dc, in: %w(d c)

  after_create :set_chart_account_balance!
  after_update :update_chart_account_balance!
  after_destroy :undo_chart_account_balance!, if: :entry_is_confirmed
  
  delegate :is_confirmed, to: :entry, prefix: true

  def debit?
    self.dc == "d"
  end

  def credit?
    self.dc == "c"
  end

  def increase_balance! amt
    # reload to avoid cache data for using different callbacks by same self object.
    self.chart_account.reload
    self.chart_account.increase_balance! amt
  end

  def decrease_balance! amt
    # reload to avoid cache data for using different callbacks by same self object.
    self.chart_account.reload
    self.chart_account.decrease_balance! amt
  end

  def undo_chart_account_balance!
    self.debit? ? self.decrease_balance!(self.amount) : self.increase_balance!(self.amount)
  end

  private
    def set_chart_account_balance!
      if self.entry_is_confirmed  
        self.debit? ? self.increase_balance!(self.amount) : self.decrease_balance!(self.amount)
      end
    end

    def update_chart_account_balance!
      if self.entry_is_confirmed
        if self.amount_changed? && self.dc_changed? && self.amount_was != nil && self.dc_was != nil
          self.dc_was == "d" ? self.decrease_balance!(self.amount_was) : self.increase_balance!(self.amount_was)        
          self.debit? ? self.increase_balance!(self.amount) : self.decrease_balance!(self.amount)
        elsif self.amount_changed? && self.amount_was != nil
          self.debit? ? self.decrease_balance!(self.amount_was) : self.increase_balance!(self.amount_was)
          self.debit? ? self.increase_balance!(self.amount) : self.decrease_balance!(self.amount)
        elsif self.dc_changed? && self.dc_was != nil
          self.dc_was == "d" ? self.decrease_balance!(self.amount_was) : self.increase_balance!(self.amount_was)
          self.debit? ? self.increase_balance!(self.amount) : self.decrease_balance!(self.amount)
        end
      end
    end
end


