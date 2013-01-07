class ApplicationController < ActionController::Base

  protect_from_forgery

  include Meiserauth::ActionViewHelper

  before_filter :authenticate_user!, :except => :start

  def start
   if session[:user_id]
    redirect_to :dashboard
   end
  end


  def dashboard
   redirect_to :start unless session[:user_id]
  end

  #def default_url_options
  #  {:locale => I18n.locale, :debug => true }.merge(super)
  #end

end

