class DeliveryObserver < ActiveRecord::Observer

 def after_create(record)
  if record.customer.bpid == "280000001"
   p "Ist richtig"
   Delayed::Job.enqueue BundleDataJob.new(record.deliver_references)
  end
 end

 def after_update(record)

 end

end

