class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def require_login
    unless @current_user
      redirect_to login_path, alert: "You must login or signup to view this page!"
    end
  end
end
