# This is where admins can list, create, and update all the galleries in the site
class Admin::GalleriesController < AdminController
  
  def index
    @galleries = Gallery.all
    @title = "Galleries"
  end

  def new 
    @gallery = Gallery.new
    @title = "New Gallery"
    5.times{@gallery.images.build}
  end

  # if the gallery doesn't exist, just return to the list of galleries
  def edit
    @title = "Edit Gallery"
    begin
      @gallery = Gallery.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to admin_galleries_path, :flash => {:notice => "Page not found"}
    end
  end

  # If something went wrong, return to the form to let the user know what happened
  def create
    @gallery = Gallery.new(params[:gallery])
      if @gallery.save
          redirect_to admin_galleries_path(@gallery), :flash => {:success => "Page Created"}
      else
          render 'new'
      end
  end

  # if the gallery doesn't exist, just return to the list of galleries
  # If something went wrong, return to the form to let the user know what happened
  def update
    begin
      @gallery = Gallery.find(params[:id])
      if @gallery.update_attributes(params[:gallery])
        render 'show'
      else
        render 'edit'
      end
    rescue ActiveRecord::RecordNotFound
        redirect_to admin_galleries_path, :flash => {:notice => "Page not found"}
    end
  end

  # if the gallery doesn't exist, just return to the list of galleries
  def destroy
    begin
          @gallery = Gallery.find(params[:id])
          @gallery.destroy
          redirect_to admin_galleries_path, :flash => {:success => "Page Deleted"}
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_galleries_path, :flash => {:error => "Page not found"}
      end
  end

  # if the gallery doesn't exist, just return to the list of galleries
  # uses the same partial that renders the gallery for the public
  def show
    @title = "Gallery"
      begin
          @gallery = Gallery.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_galleries_path, :flash => {:notice => "Page not found"}
      end

  end
end
