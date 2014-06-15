class ItemBaseDataController <  ApplicationController

	respond_to :json

	def sync_master_data
	
		#Aufruf async. Job f�r Abgleich Stammdaten Baan
		Delayed::Job.enqueue BaanMasterSyncJob.new
	
	
		data={
			:title => 'Stammdaten f�r Lohnkunden, Barzahler und Artikel angleichen',
			:message => 'Datenbank wird im Hintergrund mit den Stammdaten von Baan aktualisiert. Die aktuellen Daten stehen in wenigen Minuten zur Verf�gung.',
			:success => true
		}
		
		render :json => data
		
	end

end