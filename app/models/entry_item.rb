class EntryItem < ApplicationRecord
  belongs_to :entry
  belongs_to :chart_account

  has_many :entry_item_tags, dependent: :destroy
  has_many :tags, through: :entry_item_tags

  validates_presence_of :dc, :chart_account, :amount

  # solr searchable block
  searchable auto_index: true, auto_remove: true do
    integer :entry_id
    integer :chart_account_id

    integer :tag_ids, multiple: true
  end
end
