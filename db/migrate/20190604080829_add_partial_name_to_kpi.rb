class AddPartialNameToKpi < ActiveRecord::Migration[5.2]
  def change
    add_column :kpis, :partial_name, :string
  end
end
