class AddKPIToWidgets < ActiveRecord::Migration[5.2]
  def change
    add_reference :widgets, :kpi, foreign_key: true
  end
end
