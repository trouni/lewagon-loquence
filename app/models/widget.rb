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
#  grid_item_position :string
#  display_type       :string
#  kpi_id             :bigint
#

class Widget < ApplicationRecord
  DISPLAY = ['line_chart', 'pie_chart', 'column_chart', 'bar_chart', 'area_chart', 'scatter_chart', 'geo_chart']
  belongs_to :report
  belongs_to :kpi
  validates :name, presence: true
end
