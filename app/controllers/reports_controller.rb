class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.owner = current_user
    if @report.save
      redirect_to @report
    else
      render 'report#new'
    end
  end

  def show
    @report = Report.find(params[:id])
    # authorize @report
  end

  def edit
    @report = Report.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
    # authorize @report
  end

  private

  def report_params
    params.require(:report).permit(:name)
  end
end
