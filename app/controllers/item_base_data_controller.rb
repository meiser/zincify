class ItemBaseDataController <  ApplicationController

	respond_to :json

	def sync_master_data
	
		#Aufruf async. Job für Abgleich Stammdaten Baan
		Delayed::Job.enqueue BaanMasterSyncJob.new
	
	
		data={
			:title => 'Stammdaten für Lohnkunden, Barzahler und Artikel angleichen',
			:message => 'Datenbank wird im Hintergrund mit den Stammdaten von Baan aktualisiert. Die aktuellen Daten stehen in wenigen Minuten bereit.',
			:success => true
		}
		
		render :json => data
		
	end

end