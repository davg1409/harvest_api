class Entry < ApplicationRecord
  belongs_to :account

  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags, dependent: :destroy
  has_many :entry_items, dependent: :destroy
  has_many :attachments, dependent: :destroy

  enum entry_type: [:check, :deposit, :expense, :transfer, :custom]

  accepts_nested_attributes_for :entry_items, allow_destroy: true

  validates_presence_of :account, :entry_type, :name, :date, :amount
  validates_uniqueness_of :name, scope: :account_id

  validates :date_end, presence: true, if: :transfer?
  before_save :update_date_end!

  def set_confirm! confirm
    old_confirm = self.is_confirmed
    self.update is_confirmed: (confirm == "true" || confirm == "1")

    if self.is_confirmed && !old_confirm
      self.entry_items.each(&:redo_chart_account_balance!)
    elsif !self.is_confirmed && old_confirm
      self.entry_items.each(&:undo_chart_account_balance!)
    end

    return true
  end

  def update_attachments attachments
    attachments || []

    if attachments.present?
      self.attachments.update_all entry_id: nil
      Attachment.where(id: attachments).update_all(entry_id: self.id)  
    end
  end

  protected
    def update_date_end!
      self.date_end = nil unless self.transfer?
    end
end
