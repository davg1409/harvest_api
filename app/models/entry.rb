class Entry < ApplicationRecord
  belongs_to :account

  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags
  has_many :entry_items, dependent: :destroy
  has_many :chart_accounts

  enum entry_type: [:check, :deposit, :expense, :transfer]

  accepts_nested_attributes_for :entry_items

  validates_presence_of :account, :entry_type, :name, :date, :amount
  validates_uniqueness_of :name, scope: :account_id

  # solr searchable block
  searchable auto_index: true, auto_remove: true do
    integer :id
    boolean :is_confirmed
    time    :date
    integer :tag_ids, multiple: true

    join(:chart_account_id, target: EntryItem, type: :integer, join: { from: :entry_id, to: :id })
    join(:tag_ids, prefix: "items", target: EntryItem, type: :integer, join: { from: :entry_id, to: :id })
  end
end
