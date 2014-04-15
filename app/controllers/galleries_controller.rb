class GalleriesController < ApplicationController
	
	def index
		@galleries = Gallery.all
   		@title = "Galleries"

	end

	def show
      begin
          @gallery = Gallery.find(params[:id])
          @title=@gallery.title
      rescue ActiveRecord::RecordNotFound
          redirect_to admin_galleries_path, :flash => {:notice => "Page not found"}
      end

  end
end
