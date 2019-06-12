class Group < ApplicationRecord
  GROUP_TYPE = %w(team user)
  has_many :report_accesses
  has_many :reports, through: :report_accesses
  has_many :goup_users
  has_many :users, through: :group_users
  validates :group_type, inclusion: { in: GROUP_TYPE }
end
