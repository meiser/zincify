class Customer < ActiveRecord::Base

  attr_accessible :address, :name

  def self.synchronize_with_baan
   db = Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"])
   db.foreach_hash("select FIRST 20000 t_nama, t_seak from ttccom100110") do |r|
    Customer.create(
     :name => r["t_nama"].force_encoding("UTF-8").strip,
     :address => r["t_seak"].force_encoding("UTF-8").strip
    )
   end
   return true
  end


  def funky_method

  end

end

