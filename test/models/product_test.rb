# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  sku          :string
#  product_type :string
#  product_info :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  title        :string
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
