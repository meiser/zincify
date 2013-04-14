class MeiserDeliveriesController < ApplicationController

  # GET /deliveries
  # GET /deliveries.json
  
  
  respond_to :json, :only => :print

  def print
  	@meiser_delivery =MeiserDelivery.find(params[:data].first[:id])
    p @customer = Customer.where(:bpid => "280000001").first
    t = PrintTrigger.new
  	t.printer = "0001"
    #current_user.preferences.default_printer
  	t.label = "commission.btw"
  	t.data = "#{@meiser_delivery.commission}|#{@customer.name}|#{[@customer.name, @customer.address].join(": ")}|#{l(@meiser_delivery.indate)}|#{l(@meiser_delivery.outdate)}|#{@meiser_delivery.remarks}"
  	t.save
  	
  	data={
  		:title => 'Etikett drucken',
  		:message => 'Druckauftrag erfolgreich erstellt',
  		:success => true
  	}

  	render :json => data
  end



end

