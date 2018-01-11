class ChartAccount < ApplicationRecord
  belongs_to :parent, class_name: "ChartAccount", optional: true
  belongs_to :classification, class_name: "ChartAccountClassification"

  has_many :chart_accounts, foreign_key: :parent_id

  validates_presence_of :name, :classification, :dc
  validates_uniqueness_of :name, scope: :classification_id
  validates_inclusion_of :dc, in: %w(d c)
end
