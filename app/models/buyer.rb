class Buyer < ApplicationRecord
  has_many :orders, dependent: :destroy
end
