class MeiserBundleTagObserver < ActiveRecord::Observer

	# Rückmeldung Ankunft Bund in Verzinkerei
	def after_save(bundle)
		if bundle.deliver_reference.name == 'ScannerWA'
			#Rückmeldung Ankunft in Verzinkerei Plauen für Bunde mobiler Handscanner
			Delayed::Job.enqueue BundleArrivalJobByHandheld.new(bundle.barcode, bundle.created_at)
		end  
	end
  
end