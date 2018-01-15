class ChartAccount < ApplicationRecord
  belongs_to :parent, class_name: "ChartAccount", optional: true
  belongs_to :classification, class_name: "ChartAccountClassification", optional: true

  belongs_to :account, optional: true
  has_many :chart_accounts, foreign_key: :parent_id

  has_many :entry_items
  has_many :entries, through: :entry_items

  validates_presence_of :name, :account
  validates_uniqueness_of :name, scope: :account_id

  before_create :inherit_from_parent

  protected
    def inherit_from_parent
      if self.parent.present?
        self.classification_id = self.parent.classification_id
        self.dc = self.parent.dc
      end
    end
end
