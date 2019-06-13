class UsersController < ApplicationController
  def create
  end
  
  def user_params
    params.require(:user).permit(:name, :owner_id, :photo)
  end
end
