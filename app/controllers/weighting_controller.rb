class WeightingController < ApplicationController

 #skip_before_filter :http_basic_authenticate_with, :only => :poll
 
 respond_to :json, :only => :poll

 def index

 end
 
 def new
 
 end
 
 def print
 
 end
 
 def poll
  begin
	  s =TCPSocket.new("172.17.206.160",8000)
	  s.puts "<FP>"
	  line = s.gets
	  scale=CSV.parse_line(line, {:col_sep => ";"})
	  #"Brutto #{scale[8]}"
	  #"Einheit Gewicht #{scale[7]}"
	  response = {
		type: "event",
		name: "scale_polling",
		data: "#{scale[8]} #{scale[7]}".strip
	  }
	  render :json => response
  rescue
	  response = {
		type: "event",
		name: "scale_polling",
		data: "..."
	  }
	  render :json => response
  end
 end

end