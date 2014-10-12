class DeliverReferenceObserver < ActiveRecord::Observer

 def after_save(record)
  
  #Extraktion Barcodes nur durch Lieferscheine, keine Barcodescanner aus WA (Warenannahme)  
  if record.name != "ScannerWA"
	#Extraktion Barcodes aus Lieferscheintabellen Baan
	Delayed::Job.enqueue BundleDataJob.new(record.id) 
  
	#Rückmeldung Ankunft in Verzinkerei Plauen
	Delayed::Job.enqueue BundleArrivalJob.new(record.name,record.created_at.to_datetime)
  end
  
 end

 
end

