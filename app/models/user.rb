class User < ActiveRecord::Base
  attr_accessible :login, :default_printer
  
  devise :ldap_authenticatable
  
  serialize :preferences, OpenStruct
  
  before_save :get_login
  
  
  def get_login
	self.login = Devise::LdapAdapter.get_ldap_param(self.email,"sAMAccountName")
  end
  
  
  def default_printer
	self.preferences.default_printer
  end
  
   
  def default_printer=(printer)
	self.preferences.default_printer= printer
  end
  
  
end
