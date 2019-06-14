# == Schema Information
#
# Table name: group_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  group_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user, uniqueness: { scope: :group }
end
