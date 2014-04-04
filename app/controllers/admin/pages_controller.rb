class Admin::PagesController < AdminController

  def index
    @pages = Page.all
    @title = "Pages"
  end

  def new 
    @page = Page.new
    @title = "New Page"
  end

  def edit
    @title = "Edit Page"
    begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end
  end

  def create
    @page = Page.new(params[:page])
    
      if @page.save
          redirect_to admin_page_path(@page), :flash => {:success => "Page Created"}
      else
          render 'new'
      end
  end

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

  def destroy
    begin
          @page = Page.find(params[:id])
          @page.destroy
          redirect_to admin_pages_path, :flash => {:success => "Page Deleted"}
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:error => "Page not found"}
      end
  end

  def show
    @title = "Page"
      begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end
  end

  def preview
    render 'preview', :layout => false
  end
end
