class ReportsController < ApplicationController
  def index
  end

  def show
    @report = Report.find(params[:id])
    # authorize @report
  end
end
