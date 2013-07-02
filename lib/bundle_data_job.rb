class BundleDataJob < Struct.new(:deliver_reference)


  def perform

   load = deliver_reference.name
   
   Meiser.foreach_baan("SELECT COUNT(*) as count FROM ttibde914120 WHERE t_load = ?",[load]) do |bund|
	(1..bund["count"]).each do |i|
		b=MeiserBundleTag.new
		b.deliver_reference = deliver_reference
		b.barcode = "003#{deliver_reference.name}"+ "#{i}".rjust(3," ")
		b.save
	end
	
   end
   
  end





end

