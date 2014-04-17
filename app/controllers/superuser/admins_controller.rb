# This controller allows superusers to create, update, and view
# all the admins who have access to the backend on the site.
class Superuser::AdminsController < SuperuserController
  def new
    @admin = Admin.new
    @title = "New Admin"
  end

  # If the admin can't be created, return to the 'create admin' form and show
  # them what went wrong.
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
    @title = " Manage Admins"
  end

  # if the admin doesn't exist, then just return to the home page for the
  # superusers backend
  def edit
    @title = "Edit Admin"
    begin
      @admin = Admin.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to superuser_admins_path, :flash => {:notice => "Admin not found"}
    end
  end


  # If the admin can't be updated, return to the 'edit admin' form and show
  # them what went wrong.
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

  # if the admin doesn't exist, then just return to the home page for the
  # superusers backend
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
