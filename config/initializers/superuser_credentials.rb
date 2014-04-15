username = Rails.env.production? ? ENV['SUPERUSER_USER_NAME'] :  'user'
password = Rails.env.production? ? ENV['SUPERUSER_PASSWORD']  :  'password'
SUPERUSER_USER_NAME = username
SUPERUSER_PASSWORD  = password