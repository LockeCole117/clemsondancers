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

  def edit
    @title = "Edit Gallery"
    begin
      @gallery = Gallery.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to admin_galleries_path, :flash => {:notice => "Page not found"}
    end
  end

  def create
    @gallery = Gallery.new(params[:gallery])
      if @gallery.save
          redirect_to admin_galleries_path(@gallery), :flash => {:success => "Page Created"}
      else
          render 'new'
      end
  end

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

  def destroy
    begin
          @gallery = Gallery.find(params[:id])
          @gallery.destroy
          redirect_to admin_galleries_path, :flash => {:success => "Page Deleted"}
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_galleries_path, :flash => {:error => "Page not found"}
      end
  end

  def show
    @title = "Gallery"
      begin
          @gallery = Gallery.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_galleries_path, :flash => {:notice => "Page not found"}
      end

  end
end
