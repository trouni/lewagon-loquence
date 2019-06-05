class Report < ApplicationRecord
  has_many :widgets
  validates :name, presence: true
end
