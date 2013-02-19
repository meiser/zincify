class DeliveryObserver < ActiveRecord::Observer

 def after_create(record)
	Delayed::Job.enqueue BundleDataJob.new(record.deliver_references) if record.customer.bpid == "280000001"
 end

 def after_update(record)
	Delayed::Job.enqueue BundleDataJob.new(record.deliver_references) if record.customer.bpid == "280000001"
 end

end

