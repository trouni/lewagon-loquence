class Order < ApplicationRecord
  belongs_to :buyer_id
  belongs_to :external_order_id
end
