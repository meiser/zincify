class BundleArrivalJob < Struct.new(:load,:scan_date)


  def perform
   sql= "UPDATE ttibde914120 SET t_adate=? where t_load=?"
   Meiser.update_baan(sql,[scan_date, load])
  end

end
