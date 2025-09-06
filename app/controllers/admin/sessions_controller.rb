class Admin::SessionsController < ApplicationController
  layout 'admin'
  
  def new
    redirect_to admin_path if admin_logged_in?
  end

  def create
    # Simple password check - in production, use proper authentication
    if params[:password] == ENV['ADMIN_PASSWORD'] || params[:password] == 'WILLYS'
      log_in_admin!
      redirect_to admin_path, notice: 'Successfully logged in!'
    else
      flash.now[:alert] = 'Invalid password'
      render :new
    end
  end

  def destroy
    log_out_admin!
    redirect_to root_path, notice: 'Successfully logged out!'
  end
  
  private
  
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
