class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :purchase_date
      t.string :shipping_country
      t.integer :order_total
      t.string :external_source

      t.timestamps
    end
  end
end
