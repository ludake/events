# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
 
  before_action :set_charset 
    def set_charset  
      headers["Content-Type"] = "text/html; charset=utf-8" 
      suppress(ActiveRecord::StatementInvalid) do 
        ActiveRecord::Base.connection.execute 'SET NAMES utf8mb4' 
      end
      
    end
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  
 protected
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user
  def authenticate
    logged_in?? true : access_denied
  end
  def logged_in?
    current_user.is_a? User
  end
  helper_method :logged_in?
  def access_denied
    flash[:notice] = t("Please login to continute!")
    redirect_to login_url and return false
  end
 
  
  
  
  
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
