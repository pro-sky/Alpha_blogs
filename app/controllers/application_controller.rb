class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:index,:edit,:update,:destroy,:show]
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  protect_from_forgery with: :exception

  private

  def require_user
    if !logged_in?
      flash[:alert] =" You must be signed in"
      redirect_to login_path
    end
  end

  def authenticate_user!
    unless current_user
    flash[:alert] = "You must be signed in to access this page."
    redirect_to login_path
    end
  end
end
