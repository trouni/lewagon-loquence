# == Schema Information
#
# Table name: reports
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Report < ApplicationRecord
  has_many :widgets, dependent: :destroy
  has_many :kpis, through: :widgets
  has_many :report_accesses
  has_many :users, through: :report_accesses
  belongs_to :owner, class_name: "User"
  delegate :company, to: :owner

  validates :name, presence: true
end
