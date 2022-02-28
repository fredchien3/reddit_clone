class ApplicationController < ActionController::Base
  helper_method :current_user
  
  private
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.session_token
    @current_user = user
  end

  def log_out!
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def require_logged_in
    if session[:session_token].nil?
      redirect_to new_session_url, notice: "Please sign in first!"
    end
  end

end
