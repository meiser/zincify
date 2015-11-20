class CashPayer < ActiveRecord::Base

	attr_accessible :address, :telephone, :addresscode, :name, :search_string
  
	def self.synchronize_with_baan
		CashPayer.transaction do
			oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
			oracle.exec("SELECT address.t$cadr, address.t$seak, address.t$nama, address.t$namb, address.t$telp, address.t$namc, address.t$namd, address.t$hono, address.t$pobn, address.t$pstc, address.t$namf, city.t$dsca FROM ln61.ttccom130280 address JOIN ln61.ttccom139280 city on city.t$city = address.t$ccit where address.t$cadr LIKE '2808%'") do |row|
				c=CashPayer.find_or_initialize_by_addresscode(row.delete_at(0).strip)
				c.seak = row.delete_at(0).strip
				c.name = [row.delete_at(0).strip, row.delete_at(0).strip].compact.reject(&:blank?).join " "
				c.telephone = row.delete_at(0).strip
				c.address = row.compact.reject(&:blank?).join " "
				c.save
			end
		end
	end
  
	def search_string
		[self.seak, self.name, self.address].join(" ")
	end
 
end
