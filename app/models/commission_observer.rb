class CommissionObserver < ActiveRecord::Observer

#observe :commit
 def after_save(record)
  begin
    message = {:channel => "/messages/new", :data => SecureRandom.hex(16), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse(FAYE_URL)
    Net::HTTP.post_form(uri, :message => message.to_json)
  rescue
    p "TODO: CREATE ASYNC, DELAYED JOB"
  end
 end

end

