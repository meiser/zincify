class BundleArrivalJobByHandheld < Struct.new(:meiser_bundle_tag_id)

	def perform
	
		begin
			bundle = MeiserBundleTag.find(meiser_bundle_tag_id)
			
			bundle_id = bundle.barcode
			
			art = bundle_id[0,3]
			load = bundle_id[3,9]
			#Enterprise Unit Infor LN
			ncmp = bundle_id[12,3]
			
			#Kommission des Bundes für Infofeld in Infor LN ermitteln

			md = MeiserDelivery.find(bundle.deliver_reference.delivery_id)
	   
			if art == '003' and bundle_id.length == 15
				oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
				oracle.exec("UPDATE ln61.ttibde914101 SET t$adate = :1, t$ref = :2 where t$ncmp = :3 and t$load = :4", bundle.created_at.to_datetime.utc, md.tag, ncmp, load)
				oracle.commit
			end
		rescue ActiveRecord::RecordNotFound

		end
	end

end



