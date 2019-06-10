# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint
#

class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :reports, through: :users, dependent: :destroy
  belongs_to :owner, class_name: "User"

  validates :name, uniqueness: true
end
