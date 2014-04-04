module DeviseControllerInstanceMethods
	def login_admin
		@admin = admins(:john)
		login_as_admin(@admin)
	end

	def current_admin
		return subject.current_admin
	end

	def login_as_admin(admin)
		@request.env["devise.mapping"] = Devise.mappings[:admin]
		if subject.admin_signed_in?
			subject.sign_out :admin
		end

		subject.sign_in admin
	end

	def logout_admin
		@request.env["devise.mapping"] = Devise.mappings[:admin]
      	subject.sign_out :admin
	end
end