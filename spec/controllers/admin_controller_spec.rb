require 'spec_helper'

describe AdminController do
  #login as an admin for all of our tests (unless we are testing user permissions behavior)
  #so we can focus on ensuring our controller logic is correct rather than fighting permissions
  login_admin

  describe "GET 'index'" do
    it "should render the dashboard for the admin section" do
      get 'index'
      response.should render_template('index')
    end

    describe "permissions" do
      #we can't turn this into lambda to pass into the validation method because it won't call post properly 
      def access_resource
        get 'index'
      end

      action_uses_admin_permissions
    end
  end
end
