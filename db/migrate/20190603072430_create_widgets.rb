class CreateWidgets < ActiveRecord::Migration[5.2]
  def change
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.references :report_id, foreign_key: true

      t.timestamps
    end
  end
end
