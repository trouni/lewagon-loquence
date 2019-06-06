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
  validates :name, presence: true
end
