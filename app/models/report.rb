# == Schema Information
#
# Table name: reports
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint
#

class Report < ApplicationRecord
  has_many :widgets, dependent: :destroy
  has_many :kpis, through: :widgets
  has_many :report_accesses, dependent: :destroy
  has_many :groups, through: :report_accesses
  has_many :group_users, through: :groups
  has_many :users, through: :group_users
  belongs_to :owner, class_name: "User"
  delegate :company, to: :owner
  after_create :create_report_access

  validates :name, presence: true
  RANDOMIMAGES = ["index_random_report_1.png", "index_random_report_2.png"]

  def most_recent_widget_date
    return updated_at.strftime('%e %b %Y %H:%M:%S%p') if widgets.empty?

    widgets.order(updated_at: :desc).first.updated_at.strftime('%e %b %Y %H:%M:%S%p')
  end

  def create_report_access
    ReportAccess.create(report: self, group: owner.groups.find_by(group_type: "user"))
  end
end



































