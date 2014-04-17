# This controller is simply used to make sure the Devise login
# views fit the admin styling
class Admin::SessionsController < Devise::SessionsController
  layout 'admin'
end
