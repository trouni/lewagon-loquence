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
    {
      chart_data:
        Order.group_by_week(:purchase_date).sum(:order_total_cents)
    }
  end

  # ORDERS

  def self.avg_order_amount_and_items
    {
      chart_data: [
        ["Average order amount", Order.all.average("order_total_cents").round],
        ["Average number of items per order", Order.all.average("items_total")]
      ]
    }
  end

  def self.avg_qty_per_product
    {
      chart_data:
        OrderItem.joins(:product).group("products.title").average("quantity").sort_by { |_k, v| -v }.first(5)
    }
  end

  def self.number_of_items_sold
    {
      total:
        Order.joins(:order_items).sum(:quantity),
      chart_data:
        Order.joins(:order_items).group_by_month(:purchase_date).sum(:quantity)
    }
  end

  # PRODUCTS

  def self.best_seller
    {
      chart_data: ""
    }
  end

  def self.slow_mover
    {
      chart_data: ""
    }
  end

  def self.revenue_per_product
    {
      chart_data: ""
    }
  end

  # BUYERS

  def self.repeat_customers
    {
      chart_data: [
        ["New customers", Order.group(:buyer_id).count.group_by { |_k, v| v > 1 }[false].count],
        ["Returning customers", (Order.group(:buyer_id).count.group_by { |_k, v| v > 1 }[true] || []).count]
      ]
    }
  end
end
