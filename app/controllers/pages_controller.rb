class PagesController < ApplicationController

  def show
      @title = "Page"
      begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_pages_path, :flash => {:notice => "Page not found"}
      end

  end
end
