require 'faye'
require File.expand_path('../config/initializers/faye_config.rb', __FILE__)

class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message['ext']['auth_token'] != FAYE_TOKEN
        p "Kein TOKEN SKELLER"
        message['error'] = 'Invalid authentication token'
      end
    end
    callback.call(message)
  end
end

#Faye::WebSocket.load_adapter('thin')
faye = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye.add_extension(ServerAuth.new)
faye.listen(4000)

