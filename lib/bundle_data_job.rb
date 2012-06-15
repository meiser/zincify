class BundleDataJob < Struct.new(:delivery_number)

  def perform

   db = Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"])
   db.foreach_hash("select FIRST 20000 t_nama, t_seak from ttccom100110") do |r|
    Customer.create(
     :name => r["t_nama"].force_encoding("UTF-8").strip,
     :address => r["t_seak"].force_encoding("UTF-8").strip
    )
   end

  end


end

