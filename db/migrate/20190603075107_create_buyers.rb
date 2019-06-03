class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.string :username
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
