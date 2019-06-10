class AddOwnerToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :owner, foreign_key: { to_table: :users }
  end
end
