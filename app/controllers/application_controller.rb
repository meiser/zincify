class ApplicationController < ActionController::Base
  #rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
  #  render :text => exception, :status => 500
  #end

  protect_from_forgery

  #before_filter :authenticate_user!, :except => [:index]
  
  
  #before_filter :authenticate_netzke!
    
  http_basic_authenticate_with :name => ENV["VZPL_USER"], 
    :password => ENV["VZPL_PASSWORD"],
    :realm => "Bitte geben Sie die Zugangsdaten an"
  
  
  
     
  def start
  
  end

  def admin
  
  end
 
  def authenticate_netzke! 
    authenticate_user! if self.class.to_s != "NetzkeController" 
  end 
  
  #def default_url_options
  #  {:locale => I18n.locale, :debug => true }.merge(super)
  #end

end

