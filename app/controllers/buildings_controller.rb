class BuildingsController < ApplicationController
  def new
    @building = Building.new
  end

  def index
    @buildings = Building.all
  end

  def create
    @building = Building.new(building_params)
    if @building.save
      flash[:notice] = "Building was successfully recorded"
      redirect_to @building
    else
      render :new
    end
  end

  def show
    @building = Building.find(params[:id])
  end

  protected
  def building_params
    params.require(:building).permit(:street_address, :city, :state, :postal_code, :description, :owner_id)
  end
end
