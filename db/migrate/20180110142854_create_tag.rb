class CreateTag < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :tag_kind_id

      t.timestamps
    end
  end
end
