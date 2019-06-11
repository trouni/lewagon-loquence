class ReportsController < ApplicationController
  def index
    @reports = policy_scope(Report).order(created_at: :desc) #copied from pundit lecture note
  end

  def new
    @report = Report.new
    authorize @report
  end

  def create
    @report = Report.new(report_params)
    @report.owner = current_user
    authorize @report
    if @report.save
      redirect_to @report
    else
      render 'report#new'
    end
  end

  def show
    @report = Report.find(params[:id])
    authorize @report
  end

  def edit
    @report = Report.find(params[:id])
    authorize @report
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def report_params
    params.require(:report).permit(:name)
  end
end
