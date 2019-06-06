# == Schema Information
#
# Table name: order_items
#
#  id                     :bigint           not null, primary key
#  item_price_cents       :integer
#  quantity               :integer
#  shipping_price         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  order_id               :bigint
#  product_id             :bigint
#  external_order_item_id :string
#  currency               :string
#

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  DEFAULT_TOP_NUMBER = 5
  TIME_TYPE = %w(days week month year)
end
