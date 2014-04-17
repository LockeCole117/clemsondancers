# This class is responsible for showing anyone all the galleries in the site
# and rendering a gallery for someone to see.
class GalleriesController < ApplicationController
	
	def index
		@galleries = Gallery.all
   		@title = "Galleries"

	end

  # If the gallery doesn't exist, then we return to the home page
	def show
      begin
          @gallery = Gallery.find(params[:id])
          @title=@gallery.title
      rescue ActiveRecord::RecordNotFound
          redirect_to root_path
      end

  end
end
