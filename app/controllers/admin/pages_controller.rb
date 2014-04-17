# This is where admins can list, create, and update all the pages in the site
class Admin::PagesController < AdminController

  def index
    @pages = Page.all
    @title = "Pages"
  end

  def new
    @page = Page.new
    @title = "New Page"
  end

  # if the page doesn't exist, just return to the list of pages
  def edit
    @title = "Edit Page"
    begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end
  end

  # If something went wrong, return to the form to let the user know what happened
  def create
    @page = Page.new(params[:page])
    
      if @page.save
          redirect_to admin_page_path(@page), :flash => {:success => "Page Created"}
      else
          render 'new'
      end
  end

  # if the page doesn't exist, just return to the list of pages
  # If something went wrong, return to the form to let the user know what happened
  def update
    begin
          @page = Page.find(params[:id])
          if @page.update_attributes(params[:page])
            render 'show'
          else
            render 'edit'
          end
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end
  end

  # if the page doesn't exist, just return to the list of pages
  def destroy
    begin
          @page = Page.find(params[:id])
          @page.destroy
          redirect_to admin_pages_path, :flash => {:success => "Page Deleted"}
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:error => "Page not found"}
      end
  end

  # if the page doesn't exist, just return to the list of pages
  def show
    @title = "Page"
      begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end
  end

  #this view just renders the markdown content that's been passed to it, which allows
  #the markItUp() editor to provide a "live" preview
  def preview
    render 'preview', :layout => false
  end
end
