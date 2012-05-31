class Printer < ActiveRecord::Base
  attr_accessible :description, :ident

  def self.synchronizable?
   begin
     return true unless Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"]).nil?
   rescue
    false
   end
  end

  def self.synchronize_with_baan
   db = Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"])
   db.foreach_hash("select t_drbez, t_drcd from twhmei005120") do |r|
    Printer.create(
     :ident => r["t_drcd"].force_encoding("UTF-8").strip,
     :description => r["t_drbez"].force_encoding("UTF-8").strip
    )
   end
   return true
  end

end

