class AddExternalOrderItemIdToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :external_order_item_id, :string
  end
end
