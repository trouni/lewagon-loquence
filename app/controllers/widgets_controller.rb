class WidgetsController < ApplicationController
  before_action :set_report, only: :create
  before_action :set_widget, only: %i[edit update destroy]

  def create
    @widget = Widget.new(widget_params)
    @widget.report = @report
    @widget.name = @widget.kpi.name
    authorize @widget
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

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @kpi = KPI.find(params[:widget][:kpi_id])
    @widget.name = @kpi.name
    if @widget.update(widget_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    authorize @widget
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

  def set_report
    @report = Report.find(params[:report_id])
    authorize @report
  end

  def set_widget
    @widget = Widget.find(params[:id])
    authorize @widget
  end
end
