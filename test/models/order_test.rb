# == Schema Information
#
# Table name: orders
#
#  id                            :bigint           not null, primary key
#  purchase_date                 :datetime
#  order_total_cents             :integer
#  external_source               :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  buyer_id                      :bigint
#  order_status                  :string
#  shipping_address_region       :string
#  shipping_address_country_code :string
#  currency                      :string
#  items_total                   :integer
#  external_order_id             :string
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
