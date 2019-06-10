class AddUserToUserPlatform < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_platforms, :user, foreign_key: true
    add_reference :user_platforms, :platform, foreign_key: true
  end
end
