class CashPayerDeliveriesController < ApplicationController

  respond_to :json, :only => :print

  def print
  	@cash_payer_delivery =CashPayerDelivery.find(params[:data].first[:id])
    t = PrintTrigger.new
  	t.printer = "0001"
  	t.label = "commission.btw"
	if @cash_payer_delivery.custom_name.present?
		t.data = "#{@cash_payer_delivery.commission}|BARZAHLUNG BEI ABHOLUNG: #{@cash_payer_delivery.custom_name}|BARZAHLUNG BEI ABHOLUNG: #{@cash_payer_delivery.custom_name}|#{l(@cash_payer_delivery.indate)}|#{l(@cash_payer_delivery.outdate)}|#{@cash_payer_delivery.remarks}|#{@cash_payer_delivery.tag}"
  	else
		t.data = "#{@cash_payer_delivery.commission}|#{@cash_payer_delivery.cash_payer.name}|#{[@cash_payer_delivery.cash_payer.name, @cash_payer_delivery.cash_payer.address].join(": ")}|#{l(@cash_payer_delivery.indate)}|#{l(@cash_payer_delivery.outdate)}|#{@cash_payer_delivery.remarks}|#{@cash_payer_delivery.tag}"
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

