class Widget < ApplicationRecord
  DISPLAY = ['line_chart', 'pie_chart', 'column_chart', 'bar_chart', 'area_chart', 'scatter_chart', 'geo_chart']
  belongs_to :report
  belongs_to :kpi
  validates :name, presence: true
  validates :display_type, presence: true, inclusion: { in: DISPLAY }
end
