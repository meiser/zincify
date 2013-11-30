class BaanCompletionJob < Struct.new(:bundle_id, :weight, :date_of_scan, :user)

  def perform

   art = bundle_id[0,3]
   delivery = bundle_id[3,9]
   bund = bundle_id[12,3]
   sql= "UPDATE ttibde915120 SET t_vwght=?, t_vdate=?, t_vuser=? where t_load=? and t_bund=? and t_vdate=?"
   Meiser.update_baan(sql,[weight, date_of_scan.to_datetime, user, delivery, bund, Time.utc(1970,1,1).to_datetime])
   sql= "UPDATE ttibde914120 SET t_verz=?, t_vdate=?, t_abge=? where t_load=? and t_bund=? and t_vdate=?"
   Meiser.update_baan(sql,[true, date_of_scan.to_datetime, true, delivery, bund, Time.utc(1970,1,1).to_datetime])
   
  end

end

