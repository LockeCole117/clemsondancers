class PagesController < ApplicationController

	def show
		@Title = "Page"
    	begin
      		@page = Page.find(params[Page.url])
    	rescue ActiveRecord::RecordNotFound
      		redirect_to root_path, :flash => {:notice => "Page not found"}
    	end

	end
end
