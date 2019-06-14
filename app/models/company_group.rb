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

class CompanyGroup < ApplicationRecord
  belongs_to :company
  belongs_to :group
end
