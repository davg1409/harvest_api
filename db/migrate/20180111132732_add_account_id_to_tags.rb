class AddAccountIdToTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :tags, :account, foreign_key: true
  end
end
