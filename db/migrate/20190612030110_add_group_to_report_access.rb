class AddGroupToReportAccess < ActiveRecord::Migration[5.2]
  def change
    add_reference :report_accesses, :group, foreign_key: true
  end
end
