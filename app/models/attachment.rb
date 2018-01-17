class Attachment < ApplicationRecord
  belongs_to :entry, optional: true

  mount_uploader :document, DocumentUploader

  def filename
    self.document.filename
  end

  def url
    "#{self.document.get_host}#{self.document.url}"
  end

  def thumbnail
    self.document.url(:thumb)
  end
end