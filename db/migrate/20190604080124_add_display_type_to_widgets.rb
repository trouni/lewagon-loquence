class AddDisplayTypeToWidgets < ActiveRecord::Migration[5.2]
  def change
    add_column :widgets, :display_type, :string
  end
end
