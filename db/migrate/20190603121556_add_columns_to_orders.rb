class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_status, :string
    add_column :orders, :shipping_address_region, :string
    add_column :orders, :shipping_address_country_code, :string
    add_column :orders, :currency, :string
    add_column :orders, :items_total, :integer
    add_column :orders, :external_order_id, :string
  end
end
