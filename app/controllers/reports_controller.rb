class ReportsController < ApplicationController
  def index
    @reports = Report.all
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
end
