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

class Order < ApplicationRecord
  belongs_to :buyer
  has_many :order_items, dependent: :destroy
  # belongs_to :external_order # needs to look up the order_id in the corresponding external_source, we may not be able to use the ActiveRecord association and code this method ourself

  def self.between(start_time, end_time = DateTime.now)
    where("purchase_date >= ? AND purchase_date <= ?", start_time, end_time)
  end

  def self.oldest_order
    order(:purchase_date).first
  end

  def self.latest_order
    order(:purchase_date).last
  end

  def self.first_order_date
    oldest_order.purchase_date
  end

  def self.last_order_date
    latest_order.purchase_date
  end
end
