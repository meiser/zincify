class BundleDatiJob < Struct.new(:weighting_id)

	def perform
	
		#weighting = Weighting.find(weighting_id)
		# Weighting.where("created_at > ?", DateTime.now-1.day).each {|w| BundleDatiJob.new(w).perform}.count
		#unless weighting.nil?
		#	unless weighting.barcode.nil?
		#		if weighting.barcode.start_with? "003" then
		#			load = weighting.barcode[3,9]
		#			bund = weighting.barcode.last(3).to_i
		#			Meiser.update_baan("Insert into ttibde970120 (t_load, t_trav, t_sern, t_abr, t_aufr, t_daab, t_daauf, t_vera, t_verb, t_manu, t_refcntd, t_refcntu) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",[load, 0, bund,weighting.created_at.to_datetime,weighting.created_at.to_datetime,"","",true,true,true,0,0])
				
					#Meldung verzinktes Gewicht Oracle Datenbank Infor LN
					#Aktivierung nicht moeglich wegen nicht UE-Faehigkeit Tabelle tibde970 Auf- und Abruestprotokolle
					#oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
					#oracle.exec("INSERT INTO ln61.tttaad107000(t$curf,t$ccur,t$difo,t$refcntd,t$refcntu) VALUES(:1,:2,:3,:4,:5)", "093",r[1],r[2],0,0)
					#oracle.exec("INSERT INTO ln61.ttibde970120 (t$load, t$trav, t$sern, t$abr, t$aufr, t$daab, t$daauf, t$vera, t$verb, t$manu, t$refcntd, t$refcntu) VALUES (:1,:2,:3,:4,:5,:6,:7,:8,:9,:10,:11,:12)",load, 0, bund,weighting.created_at.to_datetime,weighting.created_at.to_datetime,"","",true,true,true,0,0)
					
		#		end
		#	end
		#end
	
	end



end