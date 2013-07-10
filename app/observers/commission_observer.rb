class CommissionObserver < ActiveRecord::Observer

include Rails.application.routes.url_helpers

#observe :commit
 def after_save(record)
  begin
    message = {:channel => "/messages/new", :data => SecureRandom.hex(16), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse(FAYE_URL)
    uri.path.gsub!(".js","")

    Net::HTTP.post_form(uri, :message => message.to_json)
  rescue
    p "TODO: CREATE ASYNC, DELAYED JOB for simple message"
  end
 end

 def after_update(record)
  begin
    message = {
      :channel => "/#{record.id}",
      :data => SecureRandom.hex(16),
      :ext => {:auth_token => FAYE_TOKEN}
    }

    p message
    uri = URI.parse(FAYE_URL)
    uri.path.gsub!(".js","")
    Net::HTTP.post_form(uri, :message => message.to_json)
  rescue
    p "TODO: CREATE ASYNC, DELAYED JOB for Status of commission"
  end
 end

end

