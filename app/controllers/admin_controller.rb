# This class is just responsible for making sure that any admin views
# requires the admin to be logged in
class AdminController < ApplicationController
  layout 'admin'

  before_filter :authenticate_admin!

  def index
    @title = "Dashboard"
  end
end
