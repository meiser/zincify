class BaanMasterSyncJob

	def perform
		CashPayer.synchronize_with_baan
		Customer.synchronize_with_baan
		
		oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
		oracle.exec("select t$item, t$dsca from ln61.ttcibd001280") do |row|
			#nur Artikel Verzinkung beginnen mit V im Normteil Artikelcode
			if row[0][9] == 'V'
				item = ItemBaseData.find_or_initialize_by(:item => row[0])
				item.description = row[1]
				item.save
			end
		end
		
	end

end
