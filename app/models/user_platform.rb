# == Schema Information
#
# Table name: user_platforms
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  platform_id :bigint
#

class UserPlatform < ApplicationRecord
  belongs_to :platform
  belongs_to :user
end
