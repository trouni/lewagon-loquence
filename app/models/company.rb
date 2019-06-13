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
  mount_uploader :photo, PhotoUploader
  has_many :users, dependent: :destroy
  has_many :reports, through: :users, dependent: :destroy
  has_many :company_groups, dependent: :destroy
  has_many :groups, through: :company_groups
  belongs_to :owner, class_name: "User"

  validates :name, uniqueness: true

  def self.placeholder
    company = find_or_initialize_by(name: "Placeholder Inc.")
    return company if company.persisted?

    company.save!(validate: false)
    company
  end
end
