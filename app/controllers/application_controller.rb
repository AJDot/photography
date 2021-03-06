class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def require_admin
    unless current_user
      flash[:danger] = 'That page does not exist!'
      redirect_to home_path
    end
  end

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
