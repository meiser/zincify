class MeiserDeliveriesController < ApplicationController

  # GET /deliveries
  # GET /deliveries.json
  
  skip_before_filter :verify_authenticity_token, :only => [:create, :bundles]
  
  respond_to :json, :only => [:print, :create, :bundles]
  
  respond_to :xls, :only => :show
  
  
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
  
  def create
   #get last meiser delivery
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
   @md.indate= DateTime.now
   @md.outdate= @md.indate+1.day
   
   if @md.valid? and params[:barcode].present? 
   
    MeiserDelivery.transaction do
		
		DeliverReference.transaction do
			dr=DeliverReference.create(:name => "ScannerWA")
			DeliverReference.transaction(:requires_new => true) do
					MeiserBundleTag.create(
						:deliver_reference => dr,
						:barcode => params[:barcode]
					)
			end
			@md.deliver_references= [dr]
			@md.save
		end
		
	end
	
	render :json => @md.tag
   else
	render :json => 99999
   end
   
  end
  
  
  def bundles
   if params[:commission].present? and params[:barcode].present?
		@md= MeiserDelivery.where(:tag => params[:commission]).first
		@dr= DeliverReference.where(:name => "ScannerWA", :delivery_id => @md).first
				
		if @md.present? and @dr.present?
			
			# Beginn Barcode bereits für diese Kommission gescannt
			@mb = MeiserBundleTag.where(
				:deliver_reference_id => @dr.id,
				:barcode => params[:barcode]
			).first
			
			if @mb.present?
				render :json => "Barcode bereits für Kommission #{@md.tag} gescannt".to_json, :status => 200
			else
				
				# Begin Barcode bereits gescannt für andere Kommission
				
				@mb = MeiserBundleTag.where(
					:barcode => params[:barcode]
				).first
				
				if @mb.present?
						render :json => "E1".to_json , :status => 200 
				else
					# Anlegen neues Bundle
					@mb=MeiserBundleTag.new(
							:deliver_reference => @dr,
							:barcode => params[:barcode]
					)
				
					if @mb.valid?
						@mb.save
						render :json => 1, :status => 200
					else
						render :json => "Fehler 99 ist aufgetreten".to_json, :status => 200
					end
				end
				
				# ende bereits gescannt für andere Kommission
			end
		else
			render :json => "Angegebene Kommission #{params[:commission]} existiert nicht".to_json, status => 200
		end
   else
		render :json => 400, :status => 400
   end
	
  end

  def show
  
	@meiser_delivery = MeiserDelivery.find(params[:id])
	
	if @meiser_delivery.present?
		@bundles = MeiserBundleTag.where(:deliver_reference_id => @meiser_delivery.deliver_reference_ids).includes(:weightings)
	end
	
	respond_with do |format|
		format.xls {
		
			book = Spreadsheet::Workbook.new
			sheet1 = book.create_worksheet :name => "Kommission #{@meiser_delivery.tag} vom #{I18n.l @meiser_delivery.created_at}"
			7.times {|x| sheet1.column(x).width = 20}
			
			sheet1.row(2).push("Erstellungsdatum:", "#{I18n.l(Time.now)}")
			
			
			
			sheet1.row(4).push("Kommission", "Barcode", "Brutto", "Netto", "Tara", "Kategorie", "Gewichtseinheit", "Verwogen am")
			#Datensaetze ab Zeile 5
			i = 5
			
			sum_brutto = 0
			sum_netto = 0
			sum_tara = 0
			
			@bundles.each do |b|
			
				if b.weightings.empty?
					sheet1.row(i).push(@meiser_delivery.tag, b.barcode)
					i = i + 1
				else
					b.weightings.each do|w|
						sheet1.row(i).push(@meiser_delivery.tag, b.barcode, w.weight_brutto, w.weight_netto, w.weight_tara, w.sort_list.description, w.weight_unit, w.created_at)
						i = i + 1
						sum_brutto = sum_brutto+w.weight_brutto
						sum_netto = sum_netto+w.weight_netto
						sum_tara = sum_tara+w.weight_tara
					end
				end
						
			end
			
			sheet1.row(i+3).push("Summen","#{@bundles.count} Bunde",sum_brutto,sum_netto, sum_tara)

			spreadsheet = StringIO.new 
			book.write spreadsheet 
			send_data spreadsheet.string, :filename => "Kommission #{@meiser_delivery.tag} vom #{I18n.l @meiser_delivery.created_at}.xls", :type =>  "application/vnd.ms-excel", :disposition => "inline"
			
		}
	end
	
  end

end

