class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate!

  def authenticate!
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end

    redirect_to login_user_path unless @current_user
  end

  helper_method :current_user

  def current_user
    @current_user
  end
end
