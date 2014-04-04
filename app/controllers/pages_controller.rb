class PagesController < ApplicationController

  def show
      @title = "Page"
      begin
          @page = Page.find(params[:id])
      rescue ActiveRecord::RecordNotFound
          redirect_to root_path
      end
  end

  def index
    @page = Page.index
    @title = @page.title
  end
end
