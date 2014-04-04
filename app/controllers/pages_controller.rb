class PagesController < ApplicationController

  def show
      begin
          @page = Page.find(params[:id])
          @title = @page.title
      rescue ActiveRecord::RecordNotFound
          redirect_to root_path
      end
  end

  def index
    @page = Page.index
    @title = @page.title
  end
end
