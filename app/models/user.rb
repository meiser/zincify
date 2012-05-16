class User < ActiveRecord::Base

  attr_accessor :login_or_email

  attr_accessible :email, :login, :password

  before_save :convert_email

  def convert_email
   self.email = self.email.downcase
  end


  def self.ldap_auth(key, password)
   ldap = initialize_ldap_con

   LDAP_CONFIG["attributes"].each do |ldap_attribute|
    result = ldap.bind_as(
      :base => LDAP_CONFIG['base'],
      :filter => "#{ldap_attribute}=#{key}",
      :password => password
    )
    if result
     puts "Authenticated with #{ldap_attribute}"
     puts "DN: #{result.first.dn}"
     puts "MAIL: #{result.first["mail"].first}"


     #user = User.find_by_email(result.first[:mail].first.downcase)

     unless user = User.find_by_email(result.first[:mail].first.downcase)
      user = User.new
      user.login = result.first["sAMAccountName"].first
      user.email = result.first["mail"].first
     end
     return user
    end
   # END result
   end

   return nil

   rescue

    return nil

  end

  class << self

  private

    def initialize_ldap_con
      options = { :host => LDAP_CONFIG['host'],
                  :port => LDAP_CONFIG['port'],
                  :encryption => (LDAP_CONFIG['ssl'] ? :simple_tls : nil),
                  :auth => {
                    :method => :simple,
                    :username => LDAP_CONFIG['admin_user'],
                    :password => LDAP_CONFIG['admin_password']
                  }
      }
      Net::LDAP.new options
    end

  end


end

