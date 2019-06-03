class FixItemPriceColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_items, :item_price, :item_price_cents
  end
end
