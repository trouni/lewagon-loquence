class OnboardingController < ApplicationController
  include Wicked::Wizard

  steps :confirm_profile, :add_platforms, :coming_soon, :setup_platform

  def show
    @body_classes = %[bg-chart]
    skip_authorization
    @user = current_user
    render_wizard
  end

  def update
    @body_classes = %[bg-chart]
    skip_authorization
    @user = current_user
    @user.update_attributes(user_params)
    sign_in(@user, bypass: true) # needed for devise
    render_wizard @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
