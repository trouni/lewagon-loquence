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

  KPI_NAMES = Dir["./app/views/kpis/*"].map { |filepath| filepath.gsub("./app/views/kpis/_","").gsub(".html.erb","")}

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

  # second, minute, hour, day, week, month, quarter, year
  # hour_of_day, day_of_week (Sun > 0, Mon > 1...), day_of_month, month_of_year

  def self.revenue(args = {})
    interval = args[:interval]
    range = args[:range] || Order.oldest_order.purchase_date..DateTime.now
    if interval
      Order.group_by_period(interval, :purchase_date, range: range).sum("order_total_cents / 100")
    else
      Order.where(purchase_date: range).sum("order_total_cents / 100")
    end
  end

  def self.shopify_revenue(args = {})
    interval = args[:interval]
    range = args[:range] || Order.oldest_order.purchase_date..DateTime.now
    if interval
      Order.where(external_source: "Shopify").group_by_period(interval, :purchase_date, range: range).sum("order_total_cents / 100")
    else
      Order.where(external_source: "Shopify").where(purchase_date: range).sum("order_total_cents / 100")
    end
  end

  # ORDERS

  def self.orders_count(args = {})
    interval = args[:interval]
    range = args[:range] || Order.oldest_order.purchase_date..DateTime.now
    if interval
      Order.group_by_period(interval, :purchase_date, range: range).count
    else
      Order.where(purchase_date: range).count
    end
  end

  def self.avg_order_amount(args = {})
    interval = args[:interval]
    range = args[:range] || Order.oldest_order.purchase_date..DateTime.now
    if interval
      result = {}
      revenue(args).each do |period, revenue|
        result[period] = (revenue / orders_count(args)[period])
      end
      return result
    else
      revenue / orders_count
    end
  end

  def self.order_count_total
    orders_count
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

  def self.unique_customers(args = {})
    interval = args[:interval]
    range = args[:range] || Order.oldest_order.purchase_date..DateTime.now
    if interval
      Order.select('buyer_id').distinct.group_by_period(interval, :purchase_date, range: range).count
    else
      Order.select('buyer_id').distinct.where(purchase_date: range).count
    end
  end

  # def self.unique_customers
  #   Order.distinct.count('buyer_id')
  # end

  def self.avg_purchase_frequency
    order_count_total.to_f / unique_customers
  end

  def self.avg_purchase_frequency_between(start_time, end_time = DateTime.now)
    order_count_total_between(start_time, end_time) / Buyer.unique_buyers_between(start_time, end_time) unless Buyer.unique_buyers_between(start_time, end_time).zero?
  end

  def self.repeat_customers
    [
      ["Repeat customers", Buyer.repeat_buyers],
      ["One-time customers", Buyer.single_time_buyers]
    ]
  end

  def self.fake_repeat_customers(args = {})
    interval = args[:interval]
    range = args[:range] || Order.oldest_order.purchase_date..DateTime.now
    if interval
      result = {}
      unique_customers(args).each do |period, customers|
        result[period] = (orders_count(args)[period] - customers)
      end
      return result
    else
      orders_count - unique_customers
    end
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
