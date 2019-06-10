class ReportAccess < ApplicationRecord
  belongs_to :user
  belongs_to :report
end
