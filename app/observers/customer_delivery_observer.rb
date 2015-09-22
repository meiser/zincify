class CustomerDeliveryObserver < ActiveRecord::Observer

 def after_create(customer_delivery)
	t = PrintTrigger.new
	t.printer = "0001"
  	t.label = "commission.btw"
	
	if customer_delivery.customer.telephone.present?
			my_telephone = " (#{customer_delivery.customer.telephone})"
	end
	
  	t.data = "#{customer_delivery.commission}|#{customer_delivery.customer.name}|#{[customer_delivery.customer.name, customer_delivery.customer.address].join(": ")} #{my_telephone ||= ""}|#{I18n.l(customer_delivery.indate)}|#{I18n.l(customer_delivery.outdate)}|#{customer_delivery.remarks}|#{customer_delivery.tag}"
  	t.save
 end
 
end
