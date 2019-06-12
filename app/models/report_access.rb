# == Schema Information
#
# Table name: report_accesses
#
#  id         :bigint           not null, primary key
#  report_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReportAccess < ApplicationRecord
  belongs_to :group
  belongs_to :report
end
