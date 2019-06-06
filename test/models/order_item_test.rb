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

require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
