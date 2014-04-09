module DeviseControllerMethods
  def login_admin
    before(:each) do
      @admin = admins(:john)
      login_as_admin(@admin)
    end
  end

  def login_as_admin(admin)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    if admin_signed_in?
      sign_out :admin
    end

    sign_in admin
  end

  def logout_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_out current_admin #log out the current admin
    end
  end
end