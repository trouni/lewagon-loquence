class DropWidgetKpis < ActiveRecord::Migration[5.2]
  def change
    drop_table :widget_kpis
  end
end
