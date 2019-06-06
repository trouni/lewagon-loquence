# == Schema Information
#
# Table name: kpis
#
#  id          :bigint           not null, primary key
#  data_type   :text
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  query       :string
#

require 'test_helper'

class KpiTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
