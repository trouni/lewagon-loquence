class AddGridSettingsToWidgets < ActiveRecord::Migration[5.2]
  def change
    add_column :widgets, :grid_item_position, :integer
    add_column :widgets, :rowspan, :integer
    add_column :widgets, :colspan, :integer
  end
end
