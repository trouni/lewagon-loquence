class OnboardingController < ApplicationController
  include Wicked::Wizard
  before_action :init_body_classes
  steps :confirm_profile, :add_platforms, :coming_soon, :setup_platform, :success

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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def init_body_classes
    @body_classes = %w[mini-navbar]
  end
end
