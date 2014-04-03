class Admin::PagesController < ApplicationController

  def index
    @pages = Page.all
    @Title = "Pages"
  end

  def new 
    @page = Page.new
    @Title = "New Page"
  end

  def edit
    @Title = "Edit Page"
    begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end
  end

  def create
    debugger
    @page = Page.new(params[:page])
    
      if @page.save
          redirect_to admin_page_path(@page), :flash => {:success => "Page Created"}
      else
          render 'new'
      end
  end

  def update
    begin
          @model = Page.find(params[:id])
          if @model.update_attributes(params[:page])
            render 'pages/show'
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
    @Title = "Page"
      begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end

  end
end
