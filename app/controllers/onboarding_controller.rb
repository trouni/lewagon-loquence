class OnboardingController < ApplicationController
  include Wicked::Wizard

  steps :confirm_profile, :add_platforms
end
