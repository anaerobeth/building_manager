class OwnersController < ApplicationController
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      flash[:notice] = "Owner was successfully recorded"
      redirect_to @owner
    else
      render :new
    end
  end

  def index
    @owners = Owner.all
    @owners.order('last_name').order('first_name')
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
    redirect_to owners_path, notice: "Owner was successfully deleted"
  end

  def show
    @owner = Owner.find(params[:id])
  end


  protected

  def owner_params
    params.require(:owner).permit(:last_name, :first_name, :company, :email, :description)
  end
end
