class RenameOrderTotal < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :order_total, :order_total_cents
  end
end
