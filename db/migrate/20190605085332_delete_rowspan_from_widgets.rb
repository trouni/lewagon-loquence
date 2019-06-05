class DeleteRowspanFromWidgets < ActiveRecord::Migration[5.2]
  def change
    remove_column :widgets, :rowspan
    remove_column :widgets, :colspan
  end
end
