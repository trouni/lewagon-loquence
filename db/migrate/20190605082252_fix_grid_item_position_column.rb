class FixGridItemPositionColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :widgets, :grid_item_position, :string
  end
end
