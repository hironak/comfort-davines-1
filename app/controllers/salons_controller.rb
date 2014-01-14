class SalonsController < ApplicationController
  # GET /salons
  # GET /salons.json
  def index
    @salons = if params[:term]
                Salon.where("name like ?", "%#{params[:term]}%")
              else
                []
              end
  end
end
