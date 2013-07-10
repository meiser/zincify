class CustomerDeliveryObserver < ActiveRecord::Observer

 def after_create(customer_delivery)
    puts "Hello"
	t = PrintTrigger.new
	t.printer = "0001"
  	t.label = "commission.btw"
  	t.data = "#{customer_delivery.commission}|#{customer_delivery.customer.name}|#{[customer_delivery.customer.name, customer_delivery.customer.address].join(": ")}|#{I18n.l(customer_delivery.indate)}|#{I18n.l(customer_delivery.outdate)}|#{customer_delivery.remarks}|#{customer_delivery.tag}"
  	t.save
 end
 
end
