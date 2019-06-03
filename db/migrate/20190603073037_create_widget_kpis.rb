class CreateWidgetKpis < ActiveRecord::Migration[5.2]
  def change
    create_table :widget_kpis do |t|
      t.text :display_type
      t.references :widget_id, foreign_key: true
      t.references :kpi_id, foreign_key: true

      t.timestamps
    end
  end
end
