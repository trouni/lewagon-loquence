class CreateWoocommerceOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :woocommerce_orders do |t|

      t.timestamps
    end
  end
end
