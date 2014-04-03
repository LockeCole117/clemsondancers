class Superuser::AdminsController < SuperuserController
  def new
    @admin = Admin.new
    @title = "New Admin"
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to superuser_admins_path, :flash => {:success => "Admin Created"}
    else
      render 'new'
    end
  end

  def index
    @admins = Admin.all
    @title = "Admins"
  end

  def edit
    @title = "Edit Admin"
    begin
      @admin = Admin.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to superuser_admins_path, :flash => {:notice => "Admin not found"}
    end
  end

  def update
    begin
      @admin = Admin.find(params[:id])
      if @admin.update_attributes(params[:admin])
        redirect_to superuser_admins_path, :flash => {:success => "Admin Updated"}
      else
        render 'edit'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to superuser_admins_path, :flash => {:notice => "Admin not found"}
    end
  end

  def destroy
    begin
      @admin = Admin.find(params[:id])
      @admin.destroy
      redirect_to superuser_admins_path, :flash => {:success => "Admin Deleted"}
    rescue ActiveRecord::RecordNotFound
      redirect_to superuser_admins_path, :flash => {:error => "Admin not found"}
    end
  end
end
