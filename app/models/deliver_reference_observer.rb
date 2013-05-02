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
 
 
 #inputfield.invisible("tibde915.wght")
 #firma = get.compnr()
	#
	#on case firma
	#case 110:
#		|disable.fields("tibde915.wght")
#		inputfield.invisible("tibde915.wght")
#		inputfield.invisible("tibde915.verzink")#
#		inputfield.invisible("tibde915.bund"#)
#		|disable.fields("tibde915.verzink")
#		disable.fields("tibde915.bund")
#		
#		disable.commands("waage")
#		disable.commands("waagetest")
#		break
#	endcase

#extern 		long 		kennziffer, firma, anzet
end

