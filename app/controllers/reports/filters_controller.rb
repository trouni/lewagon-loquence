class Reports::FiltersController < ApplicationController
  def create
    @filter = filter_params
    respond_to do |format|
      format.js
    end
  end

  private

  def filter_params
    params.require(:filter).permit(:start_date, :end_date, :platforms, :group_by)
  end
end
