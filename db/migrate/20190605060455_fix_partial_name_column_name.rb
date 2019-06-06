class FixPartialNameColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :kpis, :partial_name, :query
  end
end
