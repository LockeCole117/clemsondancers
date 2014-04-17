# This class is responsible for showing a single page based on the page URL
# and rendering the home page.
# If the home page cannot be found, then a static "fallback" page is shown
class PagesController < ApplicationController

  def show
    @page = Page.first(:conditions => {:url => params[:page_url]})
    redirect_to root_path and return if @page.nil?
    @title = @page.title
  end

  def index
    @page = Page.index
    render 'static/fallback' and return if @page.nil?
    @title = @page.title
  end
end
