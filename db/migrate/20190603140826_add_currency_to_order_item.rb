class AddCurrencyToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :currency, :string
  end
end
