class CommissionObserver < ActiveRecord::Observer

#observe :commit
 def after_save(record)
  message = {:channel => "/messages/new", :data => SecureRandom.hex(16), :ext => {:auth_token => FAYE_TOKEN}}
  uri = URI.parse(FAYE_URL)
  Net::HTTP.post_form(uri, :message => message.to_json)
 end

end

