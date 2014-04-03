module AuthHelper
  def http_login(user = SUPERUSER_USER_NAME, pw = SUPERUSER_PASSWORD)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  def http_logout
    request.env['HTTP_AUTHORIZATION'] = nil
  end
end