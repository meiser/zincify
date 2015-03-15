class BundleArrivalJobByHandheld < Struct.new(:bundle_id, :scan_date)

  def perform
  
   art = bundle_id[0,3]
   load = bundle_id[3,9]
   bund = bundle_id[12,3]
   #Enterprise Unit Infor LN
   ncmp = bund
   
   if art == '003' and bundle_id.length == 15
	sql= "UPDATE ttibde914120 SET t_adate=? where t_load=? and t_bund=?"
	Meiser.update_baan(sql,[scan_date.to_datetime, load, bund])
	
	if ncmp == '120'
		oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
		oracle.exec("UPDATE ln61.ttibde914101 SET t$adate = :1 where t$ncmp = :2 and t$load = :3", scan_date.to_datetime.utc, ncmp, load)
		oracle.commit
	end
	
	
   end
   
  end

end

