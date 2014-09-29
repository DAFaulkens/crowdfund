class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_url, alert: "Please Sign In First!"
    end
  end

  def current_user?(user)
    current_user == user
  end
  helper_method :current_user?

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized Access!"
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end
  helper_method :current_user_admin?

end
