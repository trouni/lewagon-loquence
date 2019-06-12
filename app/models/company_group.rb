class CompanyGroup < ApplicationRecord
  belongs_to :company
  belongs_to :group
end
