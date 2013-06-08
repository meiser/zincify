class WeightingObserver < ActiveRecord::Observer

 def after_create(record)
  t = PrintTrigger.new
  t.printer = "0002"
  t.label = "wiegecoupon.btw"
  if record.barcode.present?
   if record.barcode.starts_with?("VZ")
	d = CustomerDelivery.where(:commission => record.barcode).first
	t.data= "#{d.tag}|#{d.customer.name}|#{record.sort_list.number}. #{record.sort_list.description}|#{I18n.l(record.created_at, :format => :coupon)}|#{record.weight_brutto}|#{record.weight_tara}|#{record.weight_netto}|#{record.pid}|#{record.shift}"
	t.save
   end
   if record.barcode.starts_with?("B")
	d = CashPayerDelivery.where(:commission => record.barcode).first
	t.data= "#{d.tag}|#{d.custom_name.present? ? d.custom_name : d.cash_payer.name}|#{record.sort_list.number}. #{record.sort_list.description}|#{I18n.l(record.created_at, :format => :coupon)}|#{record.weight_brutto}|#{record.weight_tara}|#{record.weight_netto}|#{record.pid}|#{record.shift}"
	t.save
   end
  else
   t.data= "#{record.ref}||#{record.sort_list.number}. #{record.sort_list.description}|#{I18n.l(record.created_at, :format => :coupon)}|#{record.weight_brutto}|#{record.weight_tara}|#{record.weight_netto}|#{record.pid}|#{record.shift}"
   t.save
  end
 end

end

