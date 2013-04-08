class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  protect_from_forgery

  before_filter :authenticate_user!, :except => [:start]

  def start
  
  end


  def dashboard
  
  end

  def sencha
  end
  
  #def default_url_options
  #  {:locale => I18n.locale, :debug => true }.merge(super)
  #end

end

