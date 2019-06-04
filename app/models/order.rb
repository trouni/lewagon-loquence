class Order < ApplicationRecord
  belongs_to :buyer
  has_many :order_items, dependent: :destroy
  # belongs_to :external_order # needs to look up the order_id in the corresponding external_source, we may not be able to use the ActiveRecord association and code this method ourself
end
