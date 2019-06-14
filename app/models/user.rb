# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#  first_name             :string
#  last_name              :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :report_accesses, through: :groups
  has_many :reports, through: :report_accesses
  has_many :reports_as_owner, foreign_key: :owner_id, class_name: 'Report'
  has_many :user_platforms, dependent: :destroy
  # validates :team, inclusion: { in: TEAM }
  mount_uploader :photo, PhotoUploader
  after_create :create_user_group, :create_demo_report

  # validate first sign up without company
  before_validation do
    self.company ||= Company.placeholder
  end

  TEAM = %w[Customer_Support IT Marketing Sales]
  DEMO_REPORT = {
    layout: [
      "1 / 1 / span 6 / span 4",
      "1 / 5 / span 5 / span 8",
      "7 / 1 / span 7 / span 4",
      "6 / 9 / span 7 / span 4",
      "11 / 5 / span 5 / span 4",
      "6 / 5 / span 5 / span 4"
    ],
    kpis: [
      "unique_customers",
      "revenue",
      "repeat_customers",
      "revenue_this_month",
      "avg_customer_value",
      "customers_per_country"
    ]
  }

  def create_user_group
    if first_name && last_name
      group = Group.create!(name: name, group_type: "user")
    else
      group = Group.create!(name: email, group_type: "user")
    end
    GroupUser.create!(user: self, group: group)
  end

  def create_demo_report
    if self.company.name != "Loquence"
      report = Report.create!(
        name: "Loquence Demo Report",
        description: "This is a sample report for you to play around with.",
        owner: self
      )
      DEMO_REPORT[:layout].each_with_index do |widget_layout, index|
        kpi_name = DEMO_REPORT[:kpis][index] || KPI::KPI_NAMES.sample
        Widget.create!(
          report: report,
          name: kpi_name.tr("_", " ").capitalize,
          grid_item_position: widget_layout,
          kpi: KPI.find_by(query: kpi_name)
        )
        print "#"
      end
    end
  end

  def name
    "#{(first_name || '').capitalize} #{(last_name || '').capitalize}"
  end
end
