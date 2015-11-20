class BundleArrivalJobByHandheld < Struct.new(:bundle_id, :scan_date)

	def perform
		art = bundle_id[0,3]
		load = bundle_id[3,9]
		#Enterprise Unit Infor LN
		ncmp = bundle_id[12,3]
   
		if art == '003' and bundle_id.length == 15
			oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
			oracle.exec("UPDATE ln61.ttibde914101 SET t$adate = :1 where t$ncmp = :2 and t$load = :3", scan_date.to_datetime.utc, ncmp, load)
			oracle.commit
		end
	end

end

