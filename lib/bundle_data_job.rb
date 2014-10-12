class BundleDataJob < Struct.new(:deliver_reference_id)


  def perform

   deliver_reference = DeliverReference.find(deliver_reference_id)
   
   unless deliver_reference.nil?
	   load = deliver_reference.name
	   
	   Meiser.foreach_baan("SELECT DISTINCT t_bund FROM ttibde914120 where t_load = ?",[load]) do |bund|
		b=MeiserBundleTag.new
		b.deliver_reference = deliver_reference
		b.barcode = "003#{load}"+ "#{bund["t_bund"]}".rjust(3," ")
		b.save
	   end
	   
   end
  end




end

