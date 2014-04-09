module DeviseRequestMethods
	def login_admin
		before(:each) do
			@admin = admins(:john)
			sign_in_admin(@admin)
		end
	end

	def logout_admin
		before(:each) do
			visit destroy_admin_session_path
		end
	end

	private

	def sign_in_admin(admin)
		logout_admin #clear out any previous signins by logging admin out

		visit root_path
		fill_in 'Email', :with => admin.email
		fill_in 'Password', :with => admin.password
		click_button "Sign in"
	end
end