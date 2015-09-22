class CashPayerDeliveryObserver < ActiveRecord::Observer

 def after_create(cash_payer_delivery)
   	t = PrintTrigger.new
  	t.printer = "0001"
  	t.label = "cash_payer.btw"
	if cash_payer_delivery.custom_name.present?
		t.data = "#{cash_payer_delivery.commission}|#{cash_payer_delivery.custom_name}|#{cash_payer_delivery.custom_name}|#{I18n.l(cash_payer_delivery.indate)}|#{I18n.l(cash_payer_delivery.outdate)}|#{cash_payer_delivery.remarks}|#{cash_payer_delivery.tag}"
  	else
		#Telephone number from addresses Infor LN
		if cash_payer_delivery.cash_payer.telephone.present?
				my_telephone = " (#{cash_payer_delivery.cash_payer.telephone})"
		end
	
		t.data = "#{cash_payer_delivery.commission}|#{cash_payer_delivery.cash_payer.name}|#{[cash_payer_delivery.cash_payer.name, cash_payer_delivery.cash_payer.address].join(": ")} #{my_telephone ||= ""}|#{I18n.l(cash_payer_delivery.indate)}|#{I18n.l(cash_payer_delivery.outdate)}|#{cash_payer_delivery.remarks}|#{cash_payer_delivery.tag}"
  	end
	t.save
 end
 
end
