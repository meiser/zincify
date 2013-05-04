class DeliverReferenceObserver < ActiveRecord::Observer

 def after_save(record)
  Delayed::Job.enqueue BundleArrivalJob.new(record.name,DateTime.now)
 end

 def after_update(record)
  p "AN BAAN MELDEN UPDATE"
 end

 
 def after_destroy(record)
  p "AN BAAN MELDEN DELETE"
 end
 
end

