class SalonsController < ApplicationController
  # GET /salons
  # GET /salons.json
  def index
    @salons =
      if params[:term]
        Salon.where("name like ? or name_kana like ?", "%#{params[:term]}%", "%#{params[:term]}%")
      else
        Salon.none
      end
    @salons = @salons.where("address like ?", "#{params[:prefecture]}%") if params[:prefecture]
  end
end
