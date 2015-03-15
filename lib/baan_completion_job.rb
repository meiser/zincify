class BaanCompletionJob < Struct.new(:bundle_id, :weight, :date_of_scan, :user)

  def perform

   art = bundle_id[0,3]
   delivery = bundle_id[3,9]
   bund = bundle_id[12,3]
   ncmp = bund
   
   sql= "UPDATE ttibde915120 SET t_vwght=?, t_vdate=?, t_vuser=? where t_load=? and t_bund=? and t_vdate=?"
   Meiser.update_baan(sql,[weight, date_of_scan.to_datetime, user, delivery, bund, Time.utc(1970,1,1).to_datetime])
   
   sql= "UPDATE ttibde914120 SET t_verz=?, t_vdate=?, t_abge=? where t_load=? and t_bund=? and t_vdate=?"
   Meiser.update_baan(sql,[true, date_of_scan.to_datetime, true, delivery, bund, Time.utc(1970,1,1).to_datetime])
   
   
   if ncmp == '120'
		oracle = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
		#Besonderheiten Verzinkungsbund
		sql = "UPDATE ln61.ttibde915101 SET t$vwght=:1, t$vdate=:2, t$vuser=:3 where t$load=:4 and t$ncmp=:5 and t$vdate=:6"
		oracle.exec(sql,weight, date_of_scan.to_datetime.utc, user, delivery, ncmp, Time.at(0).strftime("%d.%m.%Y"))
		oracle.commit
		
		#Verzinkungsbund
		sql= "UPDATE ln61.ttibde914101 SET t$verz=:1, t$vdate=:2, t$abge=:3 where t$load=:4 and t$ncmp=:5 and t$vdate = :6"
		oracle.exec(sql,1, date_of_scan.to_datetime.utc, 1, delivery, ncmp, Time.at(0).strftime("%d.%m.%Y"))
		oracle.commit		
		
	end
   
  end

end

