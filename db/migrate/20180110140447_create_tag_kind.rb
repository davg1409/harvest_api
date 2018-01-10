class CreateTagKind < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_kinds do |t|
      t.string :name

      t.timestamps
    end

    TagKind.create(%w(Contact Location Business\ Unit Department Sales\ Channel Product\ Type).map { |tk| { name: tk } })
  end
end