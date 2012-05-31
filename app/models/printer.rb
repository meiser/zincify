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
   printers = db.cursor('select * from twhmei005120') do |cur|
    cur.open
    cur.fetch_all
   end
   db.close
   #printers.collect!{ |p| [p[1].force_encoding("UTF-8").strip,p[2].force_encoding("UTF-8").strip] }

   printers.each do |printer|
    baan_printer = Printer.create(
     :ident => printer[2].force_encoding("UTF-8").strip,
     :description => printer[1].force_encoding("UTF-8").strip
    )
   end
   return true
  end

end

