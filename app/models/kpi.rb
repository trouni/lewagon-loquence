class Kpi < ApplicationRecord
  has_many :widgets
  validates :partial_name, presence: :true
end
