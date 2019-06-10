class ReportsController < ApplicationController
  def index
    # @reports = Report.all
    @reports = policy_scope(Report).order(created_at: :desc) #copied from pundit lecture note
  end

  def show
    @report = Report.find(params[:id])
    authorize @report
  end

  def edit
    @report = Report.find(params[:id])
    authorize @report
  end
end
