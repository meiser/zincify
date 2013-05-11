class CashPayer < ActiveRecord::Base

  include MeiserRails::Informix
  
  attr_accessible :address, :addresscode, :name, :search_string
  
  def self.synchronize_with_baan
   foreach_baan("SELECT address.t_seak, address.t_cadr, address.t_nama, address.t_namb, address.t_namc, address.t_namd,address.t_hono, address.t_pobn, address.t_pstc, address.t_name, address.t_namf FROM ttccom130110 AS address where address.t_cadr LIKE '2808%'") do |r|
	c=CashPayer.find_or_initialize_by_addresscode(r.delete("t_cadr").strip)
    c.name = (r.delete("t_nama").strip+" "+r.delete("t_namb").strip).strip
    c.address = (r.map{|k,v| v.strip!}.join(" ")).strip
    c.save
   end
  end
  
  def search_string
   [name,address].join(" ")
  end
   
   
  
end
