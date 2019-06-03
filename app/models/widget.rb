class Widget < ApplicationRecord
  belongs_to :report_id
  has_many :widget_kpis
end
