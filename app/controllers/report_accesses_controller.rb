class ReportAccessesController < ApplicationController
  def create
    @report_access = ReportAccess.new(report_access_params)
    @report = Report.find(params[:report_id])
    @report_access.report = @report
    authorize @report_access
    if @report_access.save
      flash[:notice] = "#{@report_access.group.name} now has access"
      redirect_to @report
    else
      flash[:alert] = "Could not add access"
      render 'reports/show'
    end
  end

  private

  def report_access_params
    params.require(:report_access).permit(:group_id)
  end
end
