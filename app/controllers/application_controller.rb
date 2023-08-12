class ApplicationController < ActionController::Base
  helper_method :current_user, :hide_navbar?

  def hide_navbar?
    false
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def root_redirect
    if current_user
      redirect_to user_path(current_user)
    else
      redirect_to login_path
    end
  end

  protected

  def authenticate_user!
    redirect_to login_path, alert: "You need to sign in first!" unless current_user
  end
end
