class ReportsController < ApplicationController
  before_action :set_mini_navbar, only: %i[create show edit]

  def index
    @body_id = "reports-index"
    @reports = policy_scope(Report).order(created_at: :desc) # copied from pundit lecture note
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
      render 'report/new'
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

  def set_mini_navbar
    @body_classes = %w[report mini-navbar]
  end
end
