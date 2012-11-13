class Customer < ActiveRecord::Base

  include MeiserRails::Informix

  attr_accessible :address, :name


  #def self.synchronize_with_baan
   #db = Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"])
   #db.foreach_hash("select FIRST 20000 t_nama, t_seak from ttccom100110") do |r|
   # Customer.create(
   #  :name => r["t_nama"].force_encoding("UTF-8").strip,
   #  :address => r["t_seak"].force_encoding("UTF-8").strip
   # )
   #end

#where customer.t_bpid LIKE '28%'
 #  db.foreach_hash("SELECT customer.t_bpid, customer.t_nama as customer_name,
 #   address.t_nama, address.t_namb, address.t_namc,
 #   address.t_namd, address.t_pstc, address.t_name,
 #   aexddress.t_namf FROM ttccom100110 AS customer JOIN ttccom130110 AS address on customer.t_cadr = address.t_cadr
 #   where customer.t_bpid LIKE '28%'") do |r|
 #   #v.force_encoding("UTF-8")
 #   c=Customer.new
 #   c.bpid = r.delete("t_bpid").force_encoding("UTF-8").strip
 #   c.name = r.delete("customer_name").force_encoding("UTF-8").strip
 #   c.address = r.map{|k,v| v.force_encoding("UTF-8").strip!}.join(" ")
 #   c.save
 #  end

 
   def search_string
    [self.name, self.address, self.bpid].join(" ")
   end
 
   def self.synchronize_with_baan
    foreach_baan("SELECT customer.t_bpid, customer.t_nama as customer_name, address.t_namc, address.t_namd, address.t_hono, address.t_pstc, address.t_name, address.t_namf FROM ttccom100110 AS customer JOIN ttccom130110 AS address on customer.t_cadr = address.t_cadr where customer.t_bpid LIKE '28%'") do |r|
     c=Customer.find_or_initialize_by_bpid(r.delete("t_bpid").strip)
     c.name = r.delete("customer_name").strip
     c.address = r.map{|k,v| v.strip!}.join(" ")
     c.save
    end
   end

end

