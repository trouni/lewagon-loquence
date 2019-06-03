class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :item_price
      t.integer :quantity
      t.integer :shipping_price

      t.timestamps
    end
  end
end
