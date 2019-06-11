class OnboardingController < ApplicationController
  include Wicked::Wizard

  steps :confirm_profile, :add_platforms

  def show
    skip_authorization
    @user = current_user
    authorize @user
    render_wizard
  end

  def update
    skip_authorization
    @user = current_user
    authorize @user
    case step
    when :confirm_profile
      @user.update_attributes(user_params)
    end
    @user.update_attributes(user_params)
    sign_in(@user, bypass: true) # needed for devise
    render_wizard @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
