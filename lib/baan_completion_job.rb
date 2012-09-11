class BaanCompletionJob < Struct.new(:bundle_id, :weight, :date_of_scan, :user)

  def perform

   art = bundle_id[0,3]
   delivery = bundle_id[3,9]
   bund = bundle_id[12,3]
   sql= "UPDATE ttibde915120 SET t_vwght=?, t_vdate=?, t_vuser=? where t_load=? and t_bund=?"
   Meiser.update_baan(sql,[weight, date_of_scan, user, delivery, bund])

  end

end

