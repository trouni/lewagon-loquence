class CreateWidgetKPIs < ActiveRecord::Migration[5.2]
  def change
    create_table :widget_kpis do |t|
      t.text :display_type
      t.references :kpi, foreign_key: true
      t.references :widget, foreign_key: true

      t.timestamps
    end
  end
end
