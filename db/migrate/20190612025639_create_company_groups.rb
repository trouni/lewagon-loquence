class CreateCompanyGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :company_groups do |t|
      t.references :company, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
