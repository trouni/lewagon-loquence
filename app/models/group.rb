# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  group_type :string           default("team")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  GROUP_TYPES = %w(team user)
  has_many :report_accesses
  has_many :reports, through: :report_accesses
  has_many :group_users
  has_many :users, through: :group_users
  validates :group_type, inclusion: { in: GROUP_TYPES }

  def display_name
    group_type == 'team' ? "[team] #{name}" : "[user] #{name}"
  end
end
