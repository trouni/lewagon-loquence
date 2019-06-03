class Order < ApplicationRecord
  belongs_to :customer_id
  belongs_to :external_order_id
end
