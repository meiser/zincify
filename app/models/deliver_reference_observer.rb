class DeliverReferenceObserver < ActiveRecord::Observer

 def after_create(record)
	p Delayed::Job.enqueue BundleDataJob.new(record.name) if record.delivery.customer.bpid == "280000001"
 end

 def after_update(record)
	p Delayed::Job.enqueue BundleDataJob.new(record.name) if record.delivery.customer.bpid == "280000001"
 end

end

