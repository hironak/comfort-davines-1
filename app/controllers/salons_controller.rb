class SalonsController < ApplicationController
  # GET /salons
  # GET /salons.json
  def index
    @salons =
      if params[:term]
        Salon.where("name regexp ? or name_kana regexp ?", "#{params[:term]}", "#{params[:term]}")
      else
        Salon.none
      end
    @salons = @salons.where("address like ?", "#{params[:prefecture]}%") if params[:prefecture]
  end
end
