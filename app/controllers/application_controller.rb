class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  before_filter :authenticate_user!, :except => :start

  def start

  end


  def dashboard

  end



  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def authenticate_user!
    if session[:user_id]
      true
    else
      flash[:notice] = "Erst anmelden"
      redirect_to :controller => "sessions", :action => "new"
    end

  end

end

