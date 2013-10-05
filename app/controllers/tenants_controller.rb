class TenantsController < ApplicationController
  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      flash[:notice] = "Tenant was successfully recorded"
      redirect_to new_tenant_path
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
  end

  def index
    @tenants = Tenant.order('last_name')
  end

  def show

  end

  protected
  def tenant_params
    params.require(:tenant).permit(:last_name, :first_name, :building_id, :email, :description)
  end

end
