class DeliverReferenceObserver < ActiveRecord::Observer

 def after_save(record)
  
  #Extraktion Barcodes nur durch Lieferscheine, keine Barcodescanner aus WA (Warenannahme)  
  if record.name != "ScannerWA"
	#Extraktion Barcodes aus Lieferscheintabellen Baan
	Delayed::Job.enqueue BundleDataJob.new(record) 
  
	#Rückmeldung Ankunft in Verzinkerei Plauen
	Delayed::Job.enqueue BundleArrivalJob.new(record.name,record.created_at)
  end
  
 end

 def after_update(record)
  p "AN BAAN MELDEN UPDATE Anlieferreferenz"
 end

 
 def after_destroy(record)
  p "AN BAAN MELDEN DELETE Anlieferreferenz"
 end
 
end

