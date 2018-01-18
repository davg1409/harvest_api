class Attachment < ApplicationRecord
  belongs_to :entry, optional: true

  mount_uploader :document, DocumentUploader

  validates_presence_of :filename, :document

  after_save :update_url!

  def full_url
    "#{self.document.get_host}#{self.url}"
  end

  protected
    def update_url!
      self.update_attribute :url, self.document.url
    end
end