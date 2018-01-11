class ChartAccountClassification < ApplicationRecord
  has_many :chart_accounts, foreign_key: :classification_id

  validates_presence_of :name
  validates_uniqueness_of :name
end
