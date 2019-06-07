  # == Schema Information
#
# Table name: kpis
#
#  id          :bigint           not null, primary key
#  data_type   :text
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  query       :string
#

class KPI < ApplicationRecord
  has_many :widgets, dependent: :destroy
  validates :query, presence: true

  # REVENUE
  def self.revenue_total
    Order.sum("order_total_cents / 100")
  end

  def self.revenue_per_week
    Order.group_by_week(:purchase_date).sum("order_total_cents / 100")
  end

  def self.revenue_per_day
    Order.group_by_day(:purchase_date).sum("order_total_cents / 100")
  end

  # ORDERS

  def self.order_count_total
    Order.all.count
  end

  def self.avg_order_amount
    amounts = Order.group_by_week(:purchase_date).sum("order_total_cents / 100")
    avg_amount_total = revenue_total / order_count_total
    avg_amounts_total = amounts.each do |key, value|
      amounts[key] = value * 0 + avg_amount_total
    end
    return avg_amounts_total
  end

  def self.order_count_total_between(start_time, end_time = DateTime.now)
    Order.between(start_time, end_time).count
  end

  def self.avg_order_amount_and_items
    Order.group_by_week(:purchase_date).average("order_total_cents / items_total / 100")
  end

  def self.avg_qty_per_product
    OrderItem.joins(:product).group("products.title").average("quantity").sort_by { |_k, v| -v }.first(5)
  end

  def self.total_number_of_items_sold
    Order.joins(:order_items).sum(:quantity)
  end

  def self.total_number_of_items_sold_per_month
    Order.joins(:order_items).group_by_month(:purchase_date).sum(:quantity)
  end

  # PRODUCTS

  def self.best_seller
  end

  def self.slow_mover
  end

  def self.revenue_per_product
  end

  # BUYERS

  def self.unique_customers
    Order.distinct.count('buyer_id')
  end

  def self.avg_purchase_frequency
    order_count_total.to_f / unique_customers
  end

  def self.avg_purchase_frequency_between(start_time, end_time = DateTime.now)
    order_count_total_between(start_time, end_time) / Buyer.unique_buyers_between(start_time, end_time)
  end

  def self.repeat_customers
    [
      ["Repeat customers", Buyer.repeat_buyers],
      ["One-time customers", Buyer.single_time_buyers]
    ]
  end

  def self.repeat_customers_per_day
    [
      ["Returning customers", Buyer.repeat_buyers],
      ["New customers", Buyer.single_time_buyers]
    ]
  end

  def self.new_customers_per_month
    Order.group_by_month(:purchase_date).count # test
  end

  def self.customers_per_country
    Order.group(:shipping_address_country_code).count
  end

  def self.avg_customer_value
  end

  def self.total_customers
    Buyer.single_time_buyers + Buyer.repeat_buyers
  end

  # LOCATION

  def self.orders_by_country
    Order.group(:shipping_address_country_code).count
  end

  def self.orders_by_region
    Order.group(:shipping_address_region).count
  end
end
