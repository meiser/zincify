class CustomerDeliveriesController < ApplicationController

  respond_to :json, :only => :print

  def print
  	@customer_delivery =CustomerDelivery.find(params[:data].first[:id])
    t = PrintTrigger.new
  	t.printer = "0001"
  	t.label = "commission.btw"
  	t.data = "#{@customer_delivery.commission}|#{@customer_delivery.customer.name}|#{[@customer_delivery.customer.name, @customer_delivery.customer.address].join(": ")}|#{l(@customer_delivery.indate)}|#{l(@customer_delivery.outdate)}|#{@customer_delivery.remarks}|#{@customer_delivery.tag}"
  	t.save
  	
  	data={
  		:title => 'Etikett drucken',
  		:message => 'Druckauftrag erfolgreich erstellt',
  		:success => true
  	}

  	render :json => data
  end



end

