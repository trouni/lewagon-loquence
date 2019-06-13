class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @body_id = "home"
  end

  def info
  end


end
