class Widget < ApplicationRecord
  belongs_to :report
  has_many :widget_kpis
end
