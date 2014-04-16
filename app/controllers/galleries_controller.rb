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
          redirect_to root_path
      end

  end
end
