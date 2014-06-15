class BaanMasterSyncJob

	def perform
		CashPayer.synchronize_with_baan
		Customer.synchronize_with_baan
		
		BAAN_ORACLE.exec("select t$item, t$dsca from ln61.ttcibd001280") do |row|
			if row[0][9] == 'V'
				item = ItemBaseData.find_or_initialize_by_item(row[0])
				item.description = row[1]
				item.save
			end
		end
		
	end

end