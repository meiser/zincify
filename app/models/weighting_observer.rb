class WeightingObserver < ActiveRecord::Observer

 def after_save(record)
  t = PrintTrigger.new
  t.printer = "0002"
  t.label = "wiegecoupon.btw"
  if record.barcode.present?
   if record.barcode.starts_with?("VZ")
	d = CustomerDelivery.where(:commission => record.barcode).first
	t.data= "#{d.tag}|#{d.customer.name}|#{record.sort_list.number}. #{record.sort_list.description}|#{I18n.l(record.created_at, :format => :coupon)}|#{record.weight_brutto}|#{record.weight_tara}|#{record.weight_netto}|#{record.pid}|#{record.shift}"
   end
  else
   t.data= "#{record.ref}||#{record.sort_list.number}. #{record.sort_list.description}|#{I18n.l(record.created_at, :format => :coupon)}|#{record.weight_brutto}|#{record.weight_tara}|#{record.weight_netto}|#{record.pid}|#{record.shift}"
  end
  
  t.save
  
 end

end

