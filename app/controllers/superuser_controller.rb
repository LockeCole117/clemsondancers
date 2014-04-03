class SuperuserController < ApplicationController
  layout 'superuser'

  before_filter :superuser_authenticate

  def superuser_authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == SUPERUSER_USER_NAME && password == SUPERUSER_PASSWORD
    end
  end
end
