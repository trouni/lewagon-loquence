class WidgetsController < ApplicationController
  def create
    @report = Report.find(params[:report_id])
    @widget = Widget.new(widget_params)
    @widget.report = @report
    @widget.name = @widget.kpi.name
    if @widget.save
      respond_to do |format|
        format.html { redirect_to edit_report_path(@report) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'reports/edit' }
        format.js
      end
    end
  end

  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy
    respond_to do |format|
      format.html { redirect_to edit_report_path(@widget.report) }
      format.js
    end

  end

  private

  def widget_params
    params.require(:widget).permit(:name, :description, :grid_item_position, :display_type, :kpi_id)
  end
end
