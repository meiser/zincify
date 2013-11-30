class BundleDatiJob < Struct.new(:weighting)


  def perform
	# Weighting.where("created_at > ?", DateTime.now-1.day).each {|w| BundleDatiJob.new(w).perform}.count
	unless weighting.barcode.nil?
		if weighting.barcode.start_with? "003" then
		   load = weighting.barcode[3,9]
		   bund = weighting.barcode.last(3).to_i
		   Meiser.update_baan("Insert into ttibde970120 (t_load, t_trav, t_sern, t_abr, t_aufr, t_daab, t_daauf, t_vera, t_verb, t_manu, t_refcntd, t_refcntu) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",[load, 0, bund,weighting.created_at.to_datetime,weighting.created_at.to_datetime,"","",true,true,true,0,0])
		end
	end
   
  end



end