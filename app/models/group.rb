class Group < ApplicationRecord
  GROUP_TYPES = %w(team user)
  has_many :report_accesses
  has_many :reports, through: :report_accesses
  has_many :group_users
  has_many :users, through: :group_users
  validates :group_type, inclusion: { in: GROUP_TYPES }
end
