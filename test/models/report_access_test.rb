# == Schema Information
#
# Table name: report_accesses
#
#  id         :bigint           not null, primary key
#  report_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint
#

require 'test_helper'

class ReportAccessTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
