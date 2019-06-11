class ReportAccess < ActiveRecord::Migration[5.2]
  def change
    create_table :report_accesses do |t|
      t.integer :report_id
      t.integer :user_id

      t.index [:report_id, :user_id], unique: true

      t.timestamps
   end
 end
end
