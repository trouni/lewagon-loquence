class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @body_id = "home"
    @body_classes = %w[bg-chart]
  end

  def info
  end


end
