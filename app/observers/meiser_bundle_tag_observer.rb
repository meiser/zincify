class MeiserBundleTagObserver < ActiveRecord::Observer

	# R�ckmeldung Ankunft Bund in Verzinkerei
	def after_save(bundle)
		if bundle.deliver_reference.name == 'ScannerWA'
			#R�ckmeldung Ankunft in Verzinkerei Plauen f�r Bunde mobiler Handscanner
			Delayed::Job.enqueue BundleArrivalJobByHandheld.new(bundle.barcode, bundle.created_at)
		end  
	end
  
end