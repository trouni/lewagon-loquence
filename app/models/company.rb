class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :reports, through: :users, dependent: :destroy
  belongs_to :owner, class_name: "User"

  validates :name, uniqueness: true
end
