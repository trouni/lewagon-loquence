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

class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  validates :sku, presence: true, uniqueness: true

  def best_seller

  end
end
