# == Schema Information
#
# Table name: company_groups
#
#  id         :bigint           not null, primary key
#  company_id :bigint
#  group_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CompanyGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
