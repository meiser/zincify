class ItemBaseDataController <  ApplicationController

	respond_to :json

	def sync_item_base_data

	
		conn_echt = OCI8.new('bsp','triton123', '//BaanEcht:1521/erpln.meiser.de')

		conn_echt.exec("select t$item, t$dsca from erpln.ttcibd001280") do |row|
			if row[0][9] == 'V'
				item = ItemBaseData.find_or_initialize_by_item(row[0])
				item.description = row[1]
				item.save
			end
		end

		data={
			:title => 'Stammdaten Artikel angleichen',
			:message => 'Artikeldatenbank wurde erfolgreich aktualisiert',
			:success => true
		}
		
		render :json => data
		
	end

end