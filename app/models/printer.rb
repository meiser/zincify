class Printer < ActiveRecord::Base

	attr_accessible :description, :ident

	def self.synchronize_with_baan
		oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
	
		oracle.exec("select t$drbez, t$drcd from ln61.twhmei005101 where t$ncmp = 120") do |pr|
			lp = Printer.find_or_initialize_by_ident(pr[1].strip)
			lp.description = pr[0].strip
			lp.save
		end
	end

end

