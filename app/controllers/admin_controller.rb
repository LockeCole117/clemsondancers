class AdminController < ApplicationController

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
      		redirect_to root_path, :flash => {:notice => "Page not found"}
    	end
	end

	def create
		@page = Page.new(params[:id])
    
    	if @page.save
      		redirect_to model_path(@page), :flash => {:success => "Page Created"}
    	else
      		render 'new'
    	end
	end

	def update
		begin
      		@model = Page.find(params[:id])
      		if @model.update_attributes(params[:page])
        		render 'show'
      		else
        		render 'edit'
      		end
    	rescue ActiveRecord::RecordNotFound
      		redirect_to root_path, :flash => {:notice => "Page not found"}
    	end
	end

	def destroy
		begin
      		@page = Page.find(params[:id])
      		@page.destroy
      		redirect_to root_path, :flash => {:success => "Page Deleted"}
    	rescue ActiveRecord::RecordNotFound
      		redirect_to root_path, :flash => {:error => "Page not found"}
    	end
	end
end
