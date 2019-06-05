# == Schema Information
#
# Table name: kpis
#
#  id           :bigint           not null, primary key
#  data_type    :text
#  name         :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  partial_name :string
#

class KPI < ApplicationRecord
  has_many :widgets
end
