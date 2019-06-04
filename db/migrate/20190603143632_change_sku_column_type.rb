class ChangeSkuColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :sku, :string
  end
end
