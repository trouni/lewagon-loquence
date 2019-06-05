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
end
