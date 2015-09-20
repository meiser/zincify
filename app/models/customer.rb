class Customer < ActiveRecord::Base

  include MeiserRails::Informix

  attr_accessible :address, :name, :telephone
  
  has_many :deliveries

  def search_string
   [self.seak, self.name, self.address, self.bpid].join(" ")
  end

  def self.synchronize_with_baan
   #foreach_baan("SELECT customer.t_bpid, customer.t_seak as seak, customer.t_nama as customer_name, address.t_namc, address.t_namd, address.t_hono, address.t_pstc, address.t_name, address.t_namf FROM ttccom100110 AS customer JOIN ttccom130110 AS address on customer.t_cadr = address.t_cadr where customer.t_bpid LIKE '28%'") do |r|
   # c=Customer.find_or_initialize_by_bpid(r.delete("t_bpid").strip)
   # c.seak = r.delete("seak").strip
   # c.name = r.delete("customer_name").strip
   # c.address = r.map{|k,v| v.strip!}.join(" ")
   #c.save
   #end
	oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
	oracle.exec("SELECT customer.t$bpid, customer.t$seak as seak, customer.t$nama as customer_name, address.t$telp, address.t$namc, address.t$namd, address.t$hono, address.t$pstc, address.t$namf, city.t$dsca FROM ln61.ttccom100280 customer JOIN ln61.ttccom130280 address on customer.t$cadr = address.t$cadr JOIN ln61.ttccom139280 city on city.t$city = address.t$ccit") do |row|
		c=Customer.find_or_initialize_by_bpid row.delete_at(0)
		c.seak = row.delete_at(0).strip
		c.name = row.delete_at(0).strip
		c.telephone = row.delete_at(0).strip
		c.address = row.compact.reject(&:blank?).join " "
		c.save
	end
   
  end
  
end

