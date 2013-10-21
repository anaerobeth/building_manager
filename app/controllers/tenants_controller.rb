class TenantsController < ApplicationController

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      flash[:notice] = "Tenant was successfully recorded"
      redirect_to @tenant
    else
      render :new
    end
  end

  def index
    @tenants = Tenant.order('last_name')
  end

  def destroy
    @tenant = Tenant.find(params[:id])
    @tenant.destroy
    flash[:notice] = "Tenant was successfully deleted"
    redirect_to tenants_path
  end

  def index
    @tenants = Tenant.order('last_name')
  end

  def show
    @tenant = Tenant.find(params[:id])
  end


  protected
  def tenant_params
    params.require(:tenant).permit(:last_name, :first_name, :building_id, :email, :description)
  end

end
