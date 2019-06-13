class SettingsController < ApplicationController
  before_action :init_body_tag

  def account
    skip_authorization
  end

  def users
    @user = User.new
    skip_authorization
  end

  def new
    skip_authorization
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = create_password(8)
    skip_authorization
    if @user.save
      redirect_to settings_users_path
    else
      render 'settings/users'
    end
  end

  def update
    @user = User.find(user_params[:id])
    skip_authorization
    @user.update(user_params)
    redirect_to settings_users_path
  end

  private

  def init_body_tag
    @body_id = "settings"
    @body_classes = %w[expanded-navbar]
  end

  def create_password(number)
    charset = Array('A'..'Z') + Array('a'..'z')
    Array.new(number) { charset.sample }.join
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :company_id, group_ids: [])
  end
end
