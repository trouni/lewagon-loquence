class OnboardingController < ApplicationController
  include Wicked::Wizard

  steps :confirm_profile, :add_platforms

  def show
    @user = current_user

    render_wizard
  end

  def update
    @user = current_user
    case step
    when :confirm_profile
      @user.update_attributes(params[:user])
    end
    @user.update_attributes(params[:user])
    sign_in(@user, bypass: true) # needed for devise
    render_wizard @user
  end
end
