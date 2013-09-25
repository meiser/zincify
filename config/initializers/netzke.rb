Netzke::Core.setup do |config|
   config.js_direct_max_retries = 2
   config.ext_uri = "http://cdn.sencha.com/ext-4.1.1a-gpl" if ENV['EXTJS_SRC'] == 'cdn'

  # feedback delay
   config.js_feedback_delay = 8000
 end
 
 unless Rails.env.production?
  ENV["VZPL_USER"] = 'test'
  ENV["VZPL_PASSWORD"] = 'test'
end