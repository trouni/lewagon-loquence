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
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  TEAM = %w(Customer_Support IT Marketing Sales)
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
  after_create :create_user_group

  # valiate
  before_validation do
    self.company ||= Company.placeholder
  end

  def create_user_group
    if first_name
      group = Group.create!(name: "#{first_name}, #{last_name}", group_type: "user")
    else
      group = Group.create!(name: email, group_type: "user")
    end
    GroupUser.create!(user: self, group: group)
  end
end
