module ControllerPermissionValidations
  def action_uses_admin_permissions
    confirm_login_requirement #controller action requires a login if it uses admin_permissions

    #we redirect to the admin signin page if the admin has not signed in as an admin
    describe "only accessible to admins" do
      it "should allow admins to access" do
        login_admin
        access_resource
        response.should_not redirect_to new_admin_session_path
      end
    end
  end

  private

  def confirm_login_requirement
    it "should require the admin to be logged_in to access" do
      logout_admin
      access_resource
      response.should redirect_to new_admin_session_path
    end
  end
end