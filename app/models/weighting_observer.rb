class WeightingObserver < ActiveRecord::Observer

 def after_create(weighting)
  t = PrintTrigger.new
  t.printer = "0002"
  t.label = "wiegecoupon.btw"
  
  if weighting.barcode.present?
  
	tag = MeiserBundleTag.where(:barcode => weighting.barcode).first
		
	if tag.present?
		dr = DeliverReference.find(tag.deliver_reference)
		md = MeiserDelivery.find(dr.delivery_id)
		c = Customer.where(:bpid => "280000001").first
		t.data= "#{md.tag}|#{c.name}|#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|B #{weighting.barcode[-3,3].strip}"
		t.save
	else
		cd = CustomerDelivery.where(:commission => weighting.barcode).first
		if cd.present?
			t.data= "#{cd.tag}|#{cd.customer.name}|#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|"
			t.save
		else
			cpd = CashPayerDelivery.where(:commission => weighting.barcode).first
			if cpd.present?
				t.data= "#{cpd.tag}|#{cpd.custom_name.present? ? cpd.custom_name : cpd.cash_payer.name}|#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|"
				t.save
			end
		end
	end
  else
   t.data= "#{weighting.ref}||#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|"
   t.save
  end

 end
 
 def after_save(weighting)
  if weighting.barcode.present?
	Delayed::Job.enqueue BaanCompletionJob.new(weighting.barcode, weighting.weight_netto, weighting.created_at, "test")
  end
 end

end

