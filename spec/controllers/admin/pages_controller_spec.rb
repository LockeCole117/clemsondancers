require 'spec_helper'

describe Admin::PagesController do
  #login as an admin for all of our tests (unless we are testing user permissions behavior)
  #so we can focus on ensuring our controller logic is correct rather than fighting permissions
  login_admin
  render_views

   describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should return a new record" do
      get 'new'
      assigns(:page).should be_new_record
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        get 'new'
      end

      action_uses_admin_permissions
    end
  end

  describe "POST 'create'" do
    describe "failure" do

      before(:each) do
          @attr= { :title=>""}
      end

      it "should have a new page in the @page variable" do
         post 'create', :page => @attr
         assigns(:page).should be_new_record
      end

      it "should render the 'new' page" do
          post 'create', :page => @attr
          response.should render_template('new') #render_template allows us to check if a specific view has been rendered
      end

      it "should not create a page" do
          lambda do
              post 'create', :page => @attr
          end.should_not change(Page, :count) ##This checks that the count of records in User is not changed (the record was not entered)
      end
    end

    describe "success" do
      before(:each) do
        @attr= { :title=>"Test Page", :content => "Hello"}
      end

      it "should not have a new page in the @page variable" do
        post 'create', :page => @attr
        assigns(:page).should_not be_new_record
      end

      it "should have created the page successfully" do
        post 'create', :page => @attr
        Page.find_by_title(@attr[:title]).should_not be_nil
      end
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        post 'create', :page => { :title=>"Test Page", :content => "Hello"}
      end

      action_uses_admin_permissions
    end
  end

  describe "GET 'index'" do

    before(:each) do
      pages(:index)
      @pages = Page.all
    end

    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should have all the pages" do
      get 'index'
      assigns(:pages).should == @pages
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        get 'index'
      end

      action_uses_admin_permissions
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      page = pages(:index)
      get 'show', :id => page
      response.should be_success
    end

    describe "failure" do
      it "should redirect to the root path if an page is not found" do
        get 'show', :id => 999
        response.should redirect_to(admin_pages_path)
      end
    end

    describe "success" do
      before(:each) do
        @page = pages(:index)
      end

      it "should have the correct page" do
        get 'show', :id => @page
        assigns(:page).should == @page
      end
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        get 'show', :id => pages(:index)
      end

      action_uses_admin_permissions
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      page = pages(:index)
      get 'edit', :id => page
      response.should be_success
    end

    describe "failure" do
      it "should redirect to the root path if an page is not found" do
        get 'edit', :id => 999
        response.should redirect_to(admin_pages_path)
      end
    end

    describe "success" do
      before(:each) do
        @page = pages(:index)
      end

      it "should have the correct page" do
        get 'edit', :id => @page
        assigns(:page).should == @page
      end
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        get 'edit', :id => pages(:index)
      end

      action_uses_admin_permissions
    end
  end

  describe "POST 'update'" do

    describe "failure" do

      before(:each) do
          @page = pages(:index)
          @attr = {:id => @page, :title => ""}
          @modified_page = Page.new(@attr)
      end

      it "should have the unchanged page in the @page variable" do
          post 'update', :id => @page, :page => @attr
          assigns(:page).should == @page
      end

      it "should not have the changed page in the @page variable" do
          post 'update', :id => @page, :page => @attr
          assigns(:page).should_not == @modified_page
      end

      it "should render the 'edit' page" do
          post 'update', :id => @page, :page => @attr
          response.should render_template('edit') #render_template allows us to check if a specific view has been rendered
      end

      it "should not create a page" do
          lambda do
              post 'update', :id => @page, :page => @attr    
          end.should_not change(Page, :count) ##This checks that the count of records in User is not changed (the record was not entered)
      end
    end

    describe "success" do
      before(:each) do
        @page = pages(:index)
        @attr = {:id => @page, :title=>"Test Page"}
        @modified_page = Page.new(@attr)
      end

      it "should not have the unchanged page in the @page variable" do
        post 'update', :id => @page, :page => @attr
        assigns(:page).title.should_not == @page.title
      end

      it "should have the changed page in the @page variable" do
        post 'update', :id => @page, :page => @attr
        assigns(:page).title.should == @modified_page.title
      end

      it "should have created the page successfully" do
        post 'update', :id => @page, :page => @attr
        Page.find_by_title(@attr[:title]).should_not be_nil
      end
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        post 'update', :id => pages(:index), :page => {:title => "Test"}
      end

      action_uses_admin_permissions
    end
  end

  describe "POST 'destroy'" do

    describe "failure" do
      before(:each) do
        pages(:index)
      end

      it "should not destroy a an page that does not exist" do
        expect{
          post 'destroy', :id => Page.last.id + 1
        }.not_to change(Page, :count)
      end
    end

    describe "success" do
      before(:each) do
        @page = pages(:index)
      end

      it "should destory a page" do
        expect{
          post 'destroy', :id => @page
        }.to change(Page, :count).by(-1)

        expect{
          Page.find(@page)
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        post 'destroy', :id => pages(:index)
      end

      action_uses_admin_permissions
    end
  end

  describe "POST 'preview'" do
    it "should spit out the page's content after being parsed through Markdown" do
      post 'preview', :data => "#Test"
      response.body.should == "<h1>Test</h1>\n"
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        post 'preview', :data => "#Test"
      end

      action_uses_admin_permissions
    end
  end
end
