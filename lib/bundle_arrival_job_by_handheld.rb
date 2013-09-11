class BundleArrivalJobByHandheld < Struct.new(:bundle_id, :scan_date)

  def perform
  
   art = bundle_id[0,3]
   load = bundle_id[3,9]
   bund = bundle_id[12,3]
   
   if art == '003'
	sql= "UPDATE ttibde914120 SET t_adate=? where t_load=? and t_bund=?"
	Meiser.update_baan(sql,[scan_date, load, bund])
   end
   
  end

end

