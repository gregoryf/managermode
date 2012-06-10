class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :instantiate_controller_and_action_names
  
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
  end
  
  private
  
  def is_current_page?(controller, *args)
    if @current_controller == controller
      args.each do |action|
        if @current_action == action
          return true
        end
      end
      return false
    else
      false
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access that section.'
      redirect_to login_url
    end
  end
  
  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end
  
  helper_method :current_user
  helper_method :logged_in?
  helper_method :is_current_page?
end