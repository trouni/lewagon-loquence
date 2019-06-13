class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:name, :owner_id, :photo)
  end
end
