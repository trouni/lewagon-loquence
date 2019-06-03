class CreateKPIs < ActiveRecord::Migration[5.2]
  def change
    create_table :kpis do |t|
      t.text :data_type
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
