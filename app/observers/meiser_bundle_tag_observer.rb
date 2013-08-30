class MeiserBundleTagObserver < ActiveRecord::Observer

	# Rückmeldung Ankunft Bund in Verzinkerei
	def after_save(bundle)
		if bundle.deliver_reference.name == "ScannerWA"
			p bundle
		end  
	end
  
end