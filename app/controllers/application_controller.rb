class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate_normal_user!
  	redirect_to root_path unless user_signed_in? && current_user.is_normal_user? 
  end

  def authenticate_authorized_user!
  	redirect_to root_path unless user_signed_in? && current_user.is_authorized_user?
  end
  
  def authenticate_admin_user!
  	redirect_to root_path unless user_signed_in? && current_user.is_admin_user?
  end

  def authenticate_any_user!
    redirect_to root_path unless user_signed_in?
  end

end
