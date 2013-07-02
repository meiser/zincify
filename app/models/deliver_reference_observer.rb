class DeliverReferenceObserver < ActiveRecord::Observer

 def after_save(record)
  #Extraktion Barcodes aus Lieferscheintabellen Baan
  Delayed::Job.enqueue BundleDataJob.new(record)
  #Rückmeldung Ankunft in Verzinkerei Plauen
  Delayed::Job.enqueue BundleArrivalJob.new(record.name,DateTime.now)
 end

 def after_update(record)
  p "AN BAAN MELDEN UPDATE"
 end

 
 def after_destroy(record)
  p "AN BAAN MELDEN DELETE"
 end
 
end

