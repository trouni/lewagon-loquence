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
  def self.revenue_per_week
    Order.group_by_week(:purchase_date).sum("order_total_cents / 100")
  end

  def self.revenue_per_day
    Order.group_by_day(:purchase_date).sum("order_total_cents / 100")
  end

  # ORDERS

  def self.order_total
    Order.all.count
  end

  def self.avg_order_amount_and_items
    [
      ["Average order amount", Order.all.average("order_total_cents").round],
      ["Average number of items per order", Order.all.average("items_total")]
    ]
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

  def self.average_purchase_frequency
    order_total.to_f / unique_customers
  end

  def self.average_purchase_frequency
    order_total.to_f / unique_customers
  end

  def self.repeat_customers
    [
      ["New customers", Buyer.single_time_buyers],
      ["Returning customers", Buyer.repeat_buyers]
    ]
  end

  def self.repeat_customers_per_day
    [
      ["New customers", Buyer.single_time_buyers],
      ["Returning customers", Buyer.repeat_buyers]
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
end
