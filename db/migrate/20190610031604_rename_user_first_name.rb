class RenameUserFirstName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :fist_name, :first_name
  end
end
