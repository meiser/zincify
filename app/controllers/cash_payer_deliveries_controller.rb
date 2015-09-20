class CashPayerDeliveriesController < ApplicationController

  respond_to :json, :only => :print

  def print
  	@cash_payer_delivery =CashPayerDelivery.find(params[:data].first[:id])
    t = PrintTrigger.new
  	t.printer = "0001"
  	t.label = "cash_payer.btw"
	
	if @cash_payer_delivery.custom_name.present?
		t.data = "#{@cash_payer_delivery.commission}|#{@cash_payer_delivery.custom_name}|#{@cash_payer_delivery.custom_name}|#{l(@cash_payer_delivery.indate)}|#{l(@cash_payer_delivery.outdate)}|#{@cash_payer_delivery.remarks}|#{@cash_payer_delivery.tag}"
  	else
		
		#Telephone number from addresses Infor LN
		if @cash_payer_delivery.cash_payer.telephone.present?
				my_telephone = " (#{@cash_payer_delivery.cash_payer.telephone})"
		end
	
	
		t.data = "#{@cash_payer_delivery.commission}|#{@cash_payer_delivery.cash_payer.name}|#{[@cash_payer_delivery.cash_payer.name, @cash_payer_delivery.cash_payer.address].join(": ")} #{my_telephone ||= ""}|#{l(@cash_payer_delivery.indate)}|#{l(@cash_payer_delivery.outdate)}|#{@cash_payer_delivery.remarks}|#{@cash_payer_delivery.tag}"
  	end
	t.save
  	
  	data={
  		:title => 'Etikett drucken',
  		:message => 'Druckauftrag erfolgreich erstellt',
  		:success => true
  	}

  	render :json => data
  end

end

