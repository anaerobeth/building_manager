class OwnersController < ApplicationController
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      flash[:notice] = "Owner was successfully recorded"
      redirect_to new_owner_path
    else
      render :new
    end
  end

  def index
    @owners = Owner.all
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
    redirect_to owners_path, notice: "Owner was successfully deleted"


  end

  def show
    @owners = Owner.all
  end

  protected
  def owner_params
    params.require(:owner).permit(:last_name, :first_name, :company, :email, :description)
  end
end
