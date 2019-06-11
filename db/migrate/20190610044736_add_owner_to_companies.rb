class AddOwnerToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :owner, foreign_key: { to_table: :users }
  end
end
