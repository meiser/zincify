class BundleDatiJob < Struct.new(:weighting)


  def perform

	if weighting.barcode.start_with? "003" then
  
	   weighting.barcode
	   load = weighting.barcode[3,9]
	   bund = weighting.barcode.last(3).to_i
	   
	   Meiser.update_baan("Insert into ttibde970120 (t_load, t_trav, t_sern, t_abr, t_aufr, t_daab, t_daauf, t_vera, t_verb, t_manu, t_refcntd, t_refcntu) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",[load, 0, bund,weighting.created_at.to_datetime,weighting.created_at.to_datetime,"","",true,true,true,0,0])
   
	end
   
  end





end

