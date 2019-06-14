class AddShopifyActiveToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :shopify_active, :boolean, default: false
  end
end
