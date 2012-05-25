 require 'informix'

 begin
  db = Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"])
  printers = db.cursor('select * from twhmei005120') do |cur|
   cur.open
   cur.fetch_all
  end
  db.close
  printers.collect!{ |p| [p[1].force_encoding("UTF-8").strip,p[2].force_encoding("UTF-8").strip] }
 rescue
   printers = []
 ensure
   BAAN_PRINTERS = printers
 end

