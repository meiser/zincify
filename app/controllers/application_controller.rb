class ApplicationController < ActionController::Base
  protect_from_forgery


  before_filter :authenticate_user!, :except => :start

  def start

  end


  def dashboard
    render :text => "Dashboard"
  end

  private

  def authenticate_user!
    if session[:user_id]
      true
    else
      flash[:notice] = "Erst anmelden"
      redirect_to :controller => "sessions", :action => "new"
    end

  end

end

