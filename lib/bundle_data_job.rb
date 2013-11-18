class BundleDataJob < Struct.new(:deliver_reference)


  def perform

   load = deliver_reference.name
   
   Meiser.foreach_baan("SELECT DISTINCT t_bund FROM ttibde914120 where t_load = ?",[load]) do |bund|
	b=MeiserBundleTag.new
	b.deliver_reference = deliver_reference
	b.barcode = "003#{load}"+ "#{bund["t_bund"]}".rjust(3," ")
	b.save
   end
   
  end





end

