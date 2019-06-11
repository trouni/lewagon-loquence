class SettingsController < ApplicationController
  def account
  skip_authorization
  end

  def users
    skip_authorization
  end
end
