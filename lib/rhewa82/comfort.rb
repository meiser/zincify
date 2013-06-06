require 'socket'
require 'csv'

module Rhewa82
	class Comfort
	
	 ATTRIBUTES = %w( ident date time unit brutto tara netto)
	  
	 ATTRIBUTES.each do |attr|
      attr_reader attr
	 end
	 
	 def initialize(ip,port)
	  s =TCPSocket.new(ip,port)
	  s.puts "<FP>"
	  line = s.gets
	  s.close
	  scale=CSV.parse_line(line, {:col_sep => ";"})
	  @ident = scale[1].strip
	  @date = scale[2].strip
	  @time = scale[3].strip
	  @unit = scale[7].strip
	  @brutto = scale[8].strip
	  @tara =scale[9].strip
	  @netto = scale[10].strip
	 end


	end
end

