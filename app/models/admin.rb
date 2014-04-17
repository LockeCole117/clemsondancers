# This class represents the users that are able to create, modify, and delete
# pages and galleries. Admins can only be created from the superuser backend,
# and the admin backend can only be accessed after logging in as an admin
class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
