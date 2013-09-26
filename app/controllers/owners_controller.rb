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
 def destroy
    Owner.find(owner_params).destroy
    redirect_to owners_path, notice: "Owner was successfully deleted"
  end

  end

  protected
  def owner_params
    params.require(:owner).permit(:last_name, :first_name, :company, :email, :description)
  end
end
