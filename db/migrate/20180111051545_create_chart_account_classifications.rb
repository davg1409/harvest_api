class CreateChartAccountClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :chart_account_classifications do |t|
      t.string :name

      t.timestamps
    end
  end
end
