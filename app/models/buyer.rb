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
end
