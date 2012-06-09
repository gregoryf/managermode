class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def logged_in?
    current_user.present?
  end
  
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
  end
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access that section.'
      redirect_to login_url
    end
  end
  
  helper_method :current_user
  helper_method :logged_in?
end
