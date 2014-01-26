class FixJob < Struct.new(:deliver_reference)


	def perform
	
		load = deliver_reference.name
	   
		good_codes =[]
	   
		Meiser.foreach_baan("SELECT DISTINCT t_bund FROM ttibde914120 where t_load = ?",[load]) do |bund|
			#b=MeiserBundleTag.new
			#b.deliver_reference = deliver_reference
			good_codes << "003#{load}"+ "#{bund["t_bund"]}".rjust(3," ")
			#b.save
		end
		
		
		
		delete_codes = []
		
		deliver_reference.meiser_bundle_tags.each do |b|
			
			unless good_codes.include? b.barcode
				delete_codes << b.id
			end
			
		end
		
		t=MeiserBundleTag.where(id: delete_codes)
		t.delete_all
	
	end



end