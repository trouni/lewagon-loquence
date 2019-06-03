class CreateAmazonOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_orders do |t|

      t.timestamps
    end
  end
end
