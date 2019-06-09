class WidgetsController < ApplicationController
  def create
    @report = Report.find(params[:report_id])
    @widget = Widget.new(widget_params)
    @widget.report = @report
    @widget.name = @widget.kpi.name
    if @widget.save
      redirect_to edit_report_path(@report)
    else
      render 'reports/edit'
    end
  end

  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy
    redirect_to edit_report_path(@widget.report)
  end

  private

  def widget_params
    params.require(:widget).permit(:name, :description, :grid_item_position, :display_type, :kpi_id)
  end
end
