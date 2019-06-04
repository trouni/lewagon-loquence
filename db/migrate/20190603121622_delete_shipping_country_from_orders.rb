class DeleteShippingCountryFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :shipping_country
  end
end
