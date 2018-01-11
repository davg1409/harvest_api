class ChartAccount < ApplicationRecord
  belongs_to :parent, class_name: "ChartAccount", optional: true

  has_many :chart_accounts, foreign_key: :parent_id

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :classification_id
end
