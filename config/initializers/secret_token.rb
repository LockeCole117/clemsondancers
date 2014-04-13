# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
secret = Rails.env.production? ? ENV['SECRET_TOKEN'] :  '89b0a23367d36af4fce6d0314b9cd10e4a66310a7fda17fdfafb4a6d9e062d3606cfd0528604fcbb8b7714e5bb9edd8e996dba5a014ab06fc6e88558524c148f'
Clemsondancers::Application.config.secret_token = secret
