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

require 'test_helper'

class UserPlatformTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
