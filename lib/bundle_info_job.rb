class BundleInfoJob < Struct.new(:bundle)
  #get info from etikett and weight raw

  def perform

   bundle_id = bundle.barcode
  
   art = bundle_id[0,3]
   delivery = bundle_id[3,9]
   bund = bundle_id[12,3]
   
   
   Meiser.foreach_baan("SELECT t_wght, t_verzink, t_dicke FROM ttibde915120 where t_load = ? and t_bund = ?",[delivery, bund]) do |bund|
	# get weight bundle
	bundle.weight_raw = bund["t_wght"]
	
	#Besondere Verzinkung
	Meiser.foreach_baan("SELECT tttadv401000.t_ctnm from tttadv401000 where t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_cnst = ?",["ti","bde.verzink","B50C", "c", "mg1", bund["t_verzink"]]) do |domain|
				#deutsche Bezeichnung des Enum ermitteln
				Meiser.foreach_baan("SELECT tttadv402000.t_edes from tttadv402000 where t_clan = ? and t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_ctnm = ?",["3", "ti","bde.verzink","B50C", "c", "mg1", domain["t_ctnm"]]) do |domain_text|
	
					bundle.info = domain_text["t_edes"]
				
				end
	end
	
	#Zinkdicke
	Meiser.foreach_baan("SELECT tttadv401000.t_ctnm from tttadv401000 where t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_cnst = ?",["ti","bde.dicke","B50C", "c", "mg1", bund["t_dicke"]]) do |domain|
				
				#deutsche Bezeichnung des Enum ermitteln
				Meiser.foreach_baan("SELECT tttadv402000.t_edes from tttadv402000 where t_clan = ? and t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_ctnm = ?",["3", "ti","bde.dicke","B50C", "c", "mg1", domain["t_ctnm"]]) do |domain_text|
	
					bundle.zinc = domain_text["t_edes"]
				
				end
	end
		
	
	
	bundle.save
	
	
	
   end
   
  end

end