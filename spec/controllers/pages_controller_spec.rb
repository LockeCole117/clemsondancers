require 'spec_helper'

describe PagesController do

  describe "GET 'index'" do
    before do
      @page = pages(:index)
    end

    it "returns http success" do
      get 'index'
      assigns(:page).should == @page
      response.should render_template('index')
    end

    it "renders the fallback page if something went wrong" do
      Page.destroy_all
      get 'index'
      response.should render_template('static/fallback')
    end
  end

  describe "GET 'show'" do
    before do
      @page = pages(:about_us)
    end

    it "should find the page based on the url" do
      get 'show', :page_url => "about_us"
      assigns(:page).should == @page
      response.should render_template('show')
    end

    it "should not find the page based on the id" do
      get 'show', :page_url => @page.id
      response.should redirect_to(root_path)
      flash.should be_empty
    end

    it "should redirect to the root path if the page does not exist" do
      get 'show', :page_url => "blahblagh"
      assigns(:page).should_not == @page
      flash.should be_empty
    end
  end
end
