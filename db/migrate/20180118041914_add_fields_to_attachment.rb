class AddFieldsToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :thumbnail, :string
    add_column :attachments, :filename, :string
    add_column :attachments, :url, :string
  end
end
