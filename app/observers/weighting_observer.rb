class WeightingObserver < ActiveRecord::Observer

 def after_create(weighting)
  t = PrintTrigger.new
  t.printer = "0002"
  t.label = "wiegecoupon.btw"
  
  # find commission
  commission= ''
  if weighting.barcode.present?
  
	tag = MeiserBundleTag.where(:barcode => weighting.barcode).first
		
	if tag.present?
		dr = DeliverReference.find(tag.deliver_reference)
		md = MeiserDelivery.find(dr.delivery_id)
		c = Customer.where(:bpid => "280000001").first
		
		my_id = ""
		if weighting.barcode.starts_with?("003") and weighting.barcode.length == 15
			if weighting.barcode[-3,3].strip == "120"
				my_id = weighting.barcode[-12,9]
			else
				my_id = "B "+weighting.barcode[-3,3].strip
			end
		end
		t.data= "#{md.tag}|#{c.name}|#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|#{my_id}"
		t.save
		commission= md.tag
	else
		cd = CustomerDelivery.where(:commission => weighting.barcode).first
		if cd.present?
			t.data= "#{cd.tag}|#{cd.customer.name}|#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|"
			t.save
			commission= cd.tag
		else
			cpd = CashPayerDelivery.where(:commission => weighting.barcode).first
			if cpd.present?
				t.data= "#{cpd.tag}|#{cpd.custom_name.present? ? cpd.custom_name : cpd.cash_payer.name}|#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|"
				t.save
				commission= cpd.tag
			end
		end
	end
	
	weighting.update_column(:ref, commission)
  else
   t.data= "#{weighting.ref}||#{weighting.sort_list.number}. #{weighting.sort_list.description}|#{I18n.l(weighting.created_at, :format => :coupon)}|#{weighting.weight_brutto}|#{weighting.weight_tara}|#{weighting.weight_netto}|#{weighting.pid}|"
   t.save
  end
  
  #Automatisches setzen der Infor LN Artikel-Spalte an Hand der selektierten Werte aus dem Sortenverzeichnis
  #id	number	description
  #38   53	Entzinken
  #40	90	Meiser Gitterroste				
  #41	91	Meiser Treppenbau
  #42	92	Meiser Blechprofilroste
  #43	93	Meiser Weinbergpfaehle
  #44	94	Meiser privat
  
  #Artikel V702201 - nur Entzinken (Sonderpreis)	ID 155
  #Artikel V400010 – Gitterroste	ID 149
  #Artikel V400020 – Treppenbau		ID 195
  #Artikel V400050 – Blechprofilroste ID 207
  #Artikel V400040 – Weinbergpfaehle   ID 206   
  #Artikel V400100 – Meiser privat   ID 237 
  
  case weighting.sort_list_id
  when 38
    weighting.update_column(:item_base_data_id, 155)
  when 40
	weighting.update_column(:item_base_data_id, 149)
  when 41
	weighting.update_column(:item_base_data_id, 195)
  when 42
	weighting.update_column(:item_base_data_id, 207)
  when 43
	weighting.update_column(:item_base_data_id, 206)
  when 44
	weighting.update_column(:item_base_data_id,237)
  else
  end
  
 end
 
 def after_save(weighting)
  if weighting.barcode.present?
	#Rueckmeldung Verzinkungsbunde Gewicht, Datum, User
	Delayed::Job.enqueue BaanCompletionJob.new(weighting.barcode, weighting.weight_netto, weighting.created_at, weighting.pid)
	
	#Rueckmeldung Verzinkungsbunde Auf- und Abruestdatum
	#Delayed::Job.enqueue BundleDatiJob.new(weighting.id)
	
  end
  
 end
end

