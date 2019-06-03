class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :date_time
      t.string :shipping_address
      t.integer :order_total
      t.string :external_source

      t.timestamps
    end
  end
end
