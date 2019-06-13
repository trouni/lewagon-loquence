class SettingsController < ApplicationController
  before_action :init_body_tag

  def account
    skip_authorization
  end

  def users
    skip_authorization
  end

  private

  def init_body_tag
    @body_id = "settings"
    @body_classes = %w[expanded-navbar]
  end
end
