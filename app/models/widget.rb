# == Schema Information
#
# Table name: widgets
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  report_id          :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  grid_item_position :integer
#  rowspan            :integer
#  colspan            :integer
#  display_type       :string
#  kpi_id             :bigint
#

class Widget < ApplicationRecord
  belongs_to :report
  belongs_to :kpi
end
