# == Schema Information
#
# Table name: buyers
#
#  id         :bigint           not null, primary key
#  username   :string
#  email      :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Buyer < ApplicationRecord
  has_many :orders, dependent: :destroy

  def first_order_date
    orders.order(purchase_date: :asc).first.purchase_date
  end

  def last_order_date
    orders.order(purchase_date: :asc).last.purchase_date
  end

  def repeat_buyer?
    orders.count > 1
  end

  def shipping_country
    orders.last.shipping_address_country_code
  end

  def self.single_time_buyers
    Order.group(:buyer_id).count.group_by { |_k, v| v > 1 }[false].count
  end

  def self.repeat_buyers
    (Order.group(:buyer_id).count.group_by { |_k, v| v > 1 }[true] || []).count
  end

  def self.unique_buyers_between(start_time, end_time = DateTime.now)
    Order.between(start_time, end_time).distinct.count(:buyer_id)
  end
end
