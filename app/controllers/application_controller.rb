class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_admin
    redirect_to home_path unless current_user
  end

  def current_user
    @current_user ||= User.find event[:user_id] if event[:user_id]
  end
end
