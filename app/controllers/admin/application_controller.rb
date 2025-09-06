class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  
  private
  
  def authenticate_admin!
    unless admin_logged_in?
      redirect_to admin_login_path, alert: 'Please log in to access the admin panel.'
    end
  end
  
  def admin_logged_in?
    session[:admin_logged_in] == true
  end
  
  def log_in_admin!
    session[:admin_logged_in] = true
  end
  
  def log_out_admin!
    session[:admin_logged_in] = false
  end
end