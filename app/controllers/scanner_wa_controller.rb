class ScannerWaController < ApplicationController

  
  skip_before_filter :verify_authenticity_token
  
  
  # Get last commission
  def last_commission
	@ld=MeiserDelivery.first
	
	if @ld.present?
		render :text => @ld.tag
	else
		render :text => 0
	end
  end
  
  # Check commission entered by hand
  def check_commission
	@md= MeiserDelivery.where(:tag => params[:commission]).first
		
	if @md.present?
		render :text => "OK", status => 200
	else
		render :text => "Kommission #{params[:commission]} existiert nicht", :status => '200'
	end
  end
  
  
  # Create new meiser_delivery and deliver_reference 
  def new_commission
	@ld=MeiserDelivery.first
   
	if @ld.present?
		next_tag = @ld.tag.to_i+1
		next_tag = next_tag+1 if next_tag == 30000 or next_tag == 31000
		next_tag = 30001 if next_tag == 32000
		next_tag = next_tag.to_s
	else
		next_tag = "30001"
	end
   
	@md=MeiserDelivery.new
	@md.tag = next_tag
	@md.indate = DateTime.now
	@md.outdate = @md.indate+1.day
   
	if @md.valid?
	
		@md.transaction do
			dr=DeliverReference.create(:name => "ScannerWA")
			dr.meiser_delivery = @md
			dr.save
			@md.save
		end
		render :text => @md.tag
		
	end
  

  end

  # Create new barcode
  def new_barcode
	if params[:commission].present? and params[:barcode].present?
		
		@md= MeiserDelivery.where(:tag => params[:commission]).first
		
		if @md.present?
			dr = DeliverReference.where(:delivery_id =>@md.id, :name => "ScannerWA").first
			
			bundle = MeiserBundleTag.new(
				:deliver_reference => dr,
				:barcode => params[:barcode]
			)
			
			if bundle.valid?
				bundle.save
				render :nothing => true, :status => 201, :content_type => 'text/html'
				#render :text => "mit #{MeiserBundleTag.where(:deliver_reference_id => dr.id).count.to_s} Scan(s)", :status => 201
			else
				
				bundle = MeiserBundleTag.where(:barcode => params[:barcode]).first
				
				render :text => "Barcode bereits für Kommission #{bundle.deliver_reference.meiser_delivery.tag} gescannt. Ändern?", :status => 302
			end
		else
			render :text => "Kommission wurde gelöscht. Bitte auf ""Zurück"" klicken!!!", :status => 404
		end
	else
		render :text => "Barcode und Kommission nicht angegeben!!!", :status => 406
	end
  end

  
  # Update barcode to new commission
  def update_barcode
	if params[:commission].present? and params[:barcode].present?
		
		@md= MeiserDelivery.where(:tag => params[:commission]).first
		
		if @md.present?
			dr = DeliverReference.where(:delivery_id =>@md.id, :name => "ScannerWA").first
			
			bundle = MeiserBundleTag.where(:barcode => params[:barcode]).first
			bundle.deliver_reference = dr
			if bundle.valid?
				bundle.save
				render :text => "OK"
			else
				render :text => bundle.errors, :status => 406
			end
		else
			render :text => "Kommission wurde gelöscht. Bitte auf ""Zurück"" klicken!!!", :status => 404
		end
	else
		render :text => "Barcode und Kommission für die Aktualisierung nicht angegeben!!!", :status => 406
	end
	
  end
  
  # Get amount of barcodes for current commission
  def barcode_count_commission
	if params[:commission].present?
		@md= MeiserDelivery.where(:tag => params[:commission]).first
		if @md.present?
			dr = DeliverReference.where(:delivery_id =>@md.id, :name => "ScannerWA").first
			render :text => "mit #{MeiserBundleTag.where(:deliver_reference_id => dr.id).count.to_s} Scan(s)"
		else
			render :text => "Unbekannter Fehler", :status => 404
		end
	end
  end
  
  
end

