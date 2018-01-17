class Entry < ApplicationRecord
  belongs_to :account

  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags
  has_many :entry_items, dependent: :destroy
  has_many :chart_accounts
  has_many :attachments

  enum entry_type: [:check, :deposit, :expense, :transfer, :custom]

  accepts_nested_attributes_for :entry_items, allow_destroy: true

  validates_presence_of :account, :entry_type, :name, :date, :amount
  validates_uniqueness_of :name, scope: :account_id

  def set_confirm! confirm
    self.update is_confirmed: (confirm == "true" || confirm == "1")
  end
end
