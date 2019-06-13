class CompaniesController < ApplicationController
  def company_params
    params.require(:company).permit(:name, :owner_id, :photo)
  end
end
