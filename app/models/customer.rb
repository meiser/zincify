class Customer < ActiveRecord::Base

  include MeiserRails::Informix

  attr_accessible :address, :name
  
  has_many :deliveries

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

