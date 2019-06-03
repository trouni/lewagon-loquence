class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :sku
      t.string :product_type
      t.string :product_info

      t.timestamps
    end
  end
end
