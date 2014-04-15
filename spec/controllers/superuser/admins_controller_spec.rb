require 'spec_helper'

describe Superuser::AdminsController do
  before(:each) do
    http_login
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should return a new record" do
      get 'new'
      assigns(:admin).should be_new_record
    end

    it "should require that the superuser is logged in" do
      http_logout
      get 'new'
      response.status.should == 401
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end

    describe "failure" do

      before(:each) do
          @attr= { :email=>""}
      end

      it "should have a new admin in the @admin variable" do
         post 'create', :admin => @attr
         assigns(:admin).should be_new_record
      end

      it "should render the 'new' page" do
          post 'create', :admin => @attr
          response.should render_template('new') #render_template allows us to check if a specific view has been rendered
      end

      it "should not create a admin" do
          lambda do
              post 'create', :admin => @attr    
          end.should_not change(Admin, :count) ##This checks that the count of records in User is not changed (the record was not entered)
      end

      it "should require that the superuser is logged in" do
        http_logout
        post 'create', :admin => @attr
        response.status.should == 401
      end

      it "should require the correct credentials" do
        http_login("test", "test")
        post 'create', :admin => @attr
        response.status.should == 401
      end
    end

    describe "success" do
      before(:each) do
        @attr= { :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"}
      end

      it "should not have a new admin in the @admin variable" do
        post 'create', :admin => @attr
        assigns(:admin).should_not be_new_record
      end

      it "should have created the admin successfully" do
        post 'create', :admin => @attr
        Admin.find_by_email(@attr[:email]).should_not be_nil
      end

      it "should redirect to the admins path" do
        post 'create', :admin => @attr
        response.should redirect_to(superuser_admins_path)
      end

      it "should require that the superuser is logged in" do
        http_logout
        post 'create', :admin => @attr
        response.status.should == 401
      end

      it "should require the correct credentials" do
        http_login("test", "test")
        post 'create', :admin => @attr
        response.status.should == 401
      end
    end
  end

  describe "GET 'index'" do

    before(:each) do
      Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      @admins = Admin.all
    end

    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should have all the admins" do
      get 'index'
      assigns(:admins).should == @admins
    end

    it "should require that the superuser is logged in" do
      http_logout
      get 'index'
      response.status.should == 401
    end

    it "should require that the superuser is logged in" do
      http_login("test", "test")
      get 'index'
      response.status.should == 401
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      get 'edit', :id => admin
      response.should be_success
    end

    it "should require that the superuser is logged in" do
      admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      http_logout
      get 'edit', :id => admin
      response.status.should == 401
    end

    it "should require that the superuser is logged in" do
      admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      http_login("test", "test")
      get 'edit', :id => admin
      response.status.should == 401
    end

    describe "failure" do
      it "should redirect to the root path if an admin is not found" do
        get 'edit', :id => 999
        response.should redirect_to(superuser_admins_path)
      end
    end

    describe "success" do
      before(:each) do
        @admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      end

      it "should have the correct admin" do
        get 'edit', :id => @admin
        assigns(:admin).should == @admin
      end
    end
  end

  describe "POST 'update'" do

    describe "failure" do

      before(:each) do
          @admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
          @attr = {:id => @admin, :email => ""}
          @modified_admin = Admin.new(@attr)
      end

      it "should have the unchanged admin in the @admin variable" do
          post 'update', :id => @admin, :admin => @attr
          assigns(:admin).should == @admin
      end

      it "should not have the changed admin in the @admin variable" do
          post 'update', :id => @admin, :admin => @attr
          assigns(:admin).should_not == @modified_admin
      end

      it "should render the 'edit' page" do
          post 'update', :id => @admin, :admin => @attr
          response.should render_template('edit') #render_template allows us to check if a specific view has been rendered
      end

      it "should not create a admin" do
          lambda do
              post 'update', :id => @admin, :admin => @attr
          end.should_not change(Admin, :count) ##This checks that the count of records in User is not changed (the record was not entered)
      end

      it "should require that the superuser is logged in" do
        http_logout
        post 'update', :id => @admin, :admin => @attr
        response.status.should == 401
      end

      it "should require that the superuser is logged in" do
        http_login("test", "test")
        post 'update', :id => @admin, :admin => @attr
        response.status.should == 401
      end
    end

    describe "success" do
      before(:each) do
        @admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
        @attr = {:id => @admin, :email=>"john@test.com"}
        @modified_admin = Admin.new(@attr)
      end

      it "should not have the unchanged admin in the @admin variable" do
        post 'update', :id => @admin, :admin => @attr
        assigns(:admin).email.should_not == @admin.email
      end

      it "should have the changed admin in the @admin variable" do
        post 'update', :id => @admin, :admin => @attr
        assigns(:admin).email.should == @modified_admin.email
      end

      it "should have created the admin successfully" do
        post 'update', :id => @admin, :admin => @attr
        Admin.find_by_email(@attr[:email]).should_not be_nil
      end

      it "should redirect to the admins path" do
        post 'update', :id => @admin, :admin => @attr
        response.should redirect_to(superuser_admins_path)
      end

      it "should require that the superuser is logged in" do
        http_logout
        post 'update', :id => @admin, :admin => @attr
        response.status.should == 401
      end

      it "should require that the superuser is logged in" do
        http_login("test", "test")
        post 'update', :id => @admin, :admin => @attr
        response.status.should == 401
      end
    end
  end

  describe "POST 'destroy'" do

    describe "failure" do
      before(:each) do
        Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      end

      it "should not destroy a an admin that does not exist" do
        expect{
          post 'destroy', :id => Admin.last.id + 1
        }.not_to change(Admin, :count)
      end

      it "should require that the superuser is logged in" do
        http_logout
        post 'destroy', :id => Admin.last.id + 1
        response.status.should == 401
      end

      it "should require that the superuser is logged in" do
        http_login("test", "test")
        post 'destroy', :id => Admin.last.id + 1
        response.status.should == 401
      end
    end

    describe "success" do
      before(:each) do
        @admin = Admin.create!({ :email=>"test@test.com", :password => "test1234", :password_confirmation => "test1234"})
      end

      it "should destory a admin" do
        expect{
          post 'destroy', :id => @admin
        }.to change(Admin, :count).by(-1)

        expect{
          Admin.find(@admin)
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end

      it "should redirect to the admins path" do
        post 'destroy', :id => @admin
        response.should redirect_to(superuser_admins_path)
      end

      it "should require that the superuser is logged in" do
        http_logout
        post 'destroy', :id => @admin
        response.status.should == 401
      end

      it "should require that the superuser is logged in" do
        http_login("test", "test")
        post 'destroy', :id => Admin.last.id + 1
        response.status.should == 401
      end
    end
  end
end
