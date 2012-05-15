class User < ActiveRecord::Base

  attr_accessor :login_or_email

  attr_accessible :email, :login

  before_save :convert_email

  def convert_email
   self.email = self.email.downcase
  end


  def self.ldap_authenticate(key, password)
    User.first
  end


end

