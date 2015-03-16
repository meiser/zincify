class BundleInfoJob < Struct.new(:meiser_bundle_tag_id)
 
	#get info from etikett and weight raw

	def perform

		bundle = MeiserBundleTag.find(meiser_bundle_tag_id)
		unless bundle.nil?

			bundle_id = bundle.barcode
	  
			art = bundle_id[0,3]
			delivery = bundle_id[3,9]
			bund = bundle_id[12,3]
	   
			#Abfrage Informix Datenbank Baan ERP
			Meiser.foreach_baan("SELECT t_wght, t_verzink, t_dicke FROM ttibde915120 where t_load = ? and t_bund = ?",[delivery, bund]) do |bund|
				# get weight bundle
				bundle.update_column(:weight_raw, bund["t_wght"])
			
				#Besondere Verzinkung
				Meiser.foreach_baan("SELECT tttadv401000.t_ctnm from tttadv401000 where t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_cnst = ?",["ti","bde.verzink","B50C", "c", "mg1", bund["t_verzink"]]) do |domain|
					#deutsche Bezeichnung des Enum ermitteln
					Meiser.foreach_baan("SELECT tttadv402000.t_edes from tttadv402000 where t_clan = ? and t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_ctnm = ?",["3", "ti","bde.verzink","B50C", "c", "mg1", domain["t_ctnm"]]) do |domain_text|
						bundle.update_column(:info, domain_text["t_edes"])
					end
				end
		
				#Zinkdicke
				Meiser.foreach_baan("SELECT tttadv401000.t_ctnm from tttadv401000 where t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_cnst = ?",["ti","bde.dicke","B50C", "c", "mg1", bund["t_dicke"]]) do |domain|
							
					#deutsche Bezeichnung des Enum ermitteln
					Meiser.foreach_baan("SELECT tttadv402000.t_edes from tttadv402000 where t_clan = ? and t_cpac = ? and t_cdom = ? and t_vers = ? and t_rele = ? and t_cust = ? and t_ctnm = ?",["3", "ti","bde.dicke","B50C", "c", "mg1", domain["t_ctnm"]]) do |domain_text|
						bundle.update_column(:zinc, domain_text["t_edes"])
					end
				end
			end  
			#Abfrage Oracle Datenbank Infor LN
			#Lieferung wird zu Bund ID
			#Bundnummer wird Enterprise unit
		  
			if bund == '120'
			
			
				oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])

				oracle.exec("SELECT t$wght, t$verzink, t$dicke FROM ln61.ttibde915101 where t$ncmp = :1 and t$load = :2", bund, delivery) do |b|
					bundle.update_column(:weight_raw, b[0])

					#Besondere Verzinkung
					oracle.exec("SELECT tttadv401000.t$za_clab from ln61.tttadv401000 where t$cpac = :1 and t$cdom = :2 and t$vers = :3 and t$rele = :4 and t$cust = :5 and t$cnst = :6", "ti","bde.verzink","B61C", "a9", "mei1", b[1]) do |domain|
						#deutsche Bezeichnung des Enum ermitteln
						oracle.exec("SELECT t$desc FROM ln61.tttadv140000 where t$clan = :1 and t$cpac = :2 and t$vers = :3 and t$rele = :4 and t$cust = :5 and t$clab = :6","3", "ti","B61C", "a9", "mei1", domain[0]) do |domain_text|
							bundle.update_column(:info, domain_text[0])
						end
					end

					#Zinkdicke
					oracle.exec("SELECT tttadv401000.t$za_clab from ln61.tttadv401000 where t$cpac = :1 and t$cdom = :2 and t$vers = :3 and t$rele = :4 and t$cust = :5 and t$cnst = :6", "ti","bde.dicke","B61C", "a9", "mei1", b[2]) do |domain|
						#deutsche Bezeichnung des Enum ermitteln
						oracle.exec("SELECT t$desc FROM ln61.tttadv140000 where t$clan = :1 and t$cpac = :2 and t$vers = :3 and t$rele = :4 and t$cust = :5 and t$clab = :6","3", "ti","B61C", "a9", "mei1", domain[0]) do |domain_text|
							bundle.update_column(:zinc, domain_text[0])
						end
					end
					
					
				end
			
			end
		end   
	


	
	end
end