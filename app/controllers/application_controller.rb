class ApplicationController < ActionController::Base

  include Mobylette::RespondToMobileRequests

  mobylette_config do |config|
   config[:skip_xhr_requests] = false
  end

  protect_from_forgery

  helper_method :current_user

  before_filter :authenticate_user!, :except => :start
  before_filter :set_mobile
  def start
   if session[:user_id]
    redirect_to :dashboard
   end
  end


  def dashboard

  end

  private


  def set_mobile
   request.format = "mobile"
  end


  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    if session[:user_id]
      true
    else
      flash[:notice] = "Erst anmelden"
      session[:return_to] = request.path
      redirect_to :controller => "sessions", :action => "new"
    end

  end

  #def default_url_options
  #  {:locale => I18n.locale, :debug => true }.merge(super)
  #end

end

