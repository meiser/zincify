class MeiserDeliveriesController < ApplicationController

  # GET /deliveries
  # GET /deliveries.json
  
  #skip_before_filter :verify_authenticity_token, :only => [:create, :bundles]
  
  respond_to :json, :only => [:print, :print_commission, :create, :bundles]
  
  respond_to :xls, :only => :show
  
  layout 'mobile'
  
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
  
  def print_commission
	@meiser_delivery =MeiserDelivery.find(params[:data].first[:id])

	@dr = @meiser_delivery.deliver_references.try(:first)
	
	if @dr.present?
		@meiser_bundle_tag = MeiserBundleTag.new
		@meiser_bundle_tag.barcode = NextFreeNumber.generate("Meiser")
		@meiser_bundle_tag.deliver_reference = @dr
		if @meiser_bundle_tag.valid?
			@meiser_bundle_tag.save
			
			@customer = Customer.find_by_bpid("280000001")
			
			t = PrintTrigger.new
			t.printer = "0001"
			t.label = "commission.btw"
			t.data = "#{@meiser_bundle_tag.barcode}|#{@customer.name}|#{[@customer.name, @customer.address].join(": ")}|#{l(@meiser_delivery.indate)}|#{l(@meiser_delivery.outdate)}|#{@meiser_delivery.remarks}|#{@meiser_delivery.tag}"
			t.save
			
			
			data={
				:title => 'Etikett drucken',
				:message => 'Druckauftrag erfolgreich erstellt',
				:success => true
			}
		else
			data={
				:title => 'Etikett drucken',
				:message => 'Fehler 400 Resource DeliverReference not found',
				:success => false
			}
		end
	end
	
	render :json => data
  end
  
  def new
	@meiser_delivery = MeiserDelivery.new
  end
  
  def select
	@meiser_delivery = MeiserDelivery.new
  end
  
  def create
  
    if params[:meiser_delivery].present?
		@md= MeiserDelivery.where(:tag => params[:meiser_delivery][:tag]).first
		@dr= DeliverReference.where(:name => "ScannerWA", :delivery_id => @md).first
		
		if @md.present? and @dr.present?
			redirect_to new_deliver_reference_meiser_bundle_tag_path(@dr)
		else
			redirect_to select_meiser_deliveries_path
		end
	else
  
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
	   
	   if @md.valid?
			MeiserDelivery.transaction do
				@dr = DeliverReference.new(:name => "ScannerWA")
				@md.deliver_references= [@dr]
				@md.save!
			end
			redirect_to new_deliver_reference_meiser_bundle_tag_path(@dr)
	   else
		redirect_to new_meiser_delivery_path
	   end
   
	end
  end
  
  def scan
	render :text => "scan"
  end
  
  def create2
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
	@item_base_data = ItemBaseData.all
	
	if @meiser_delivery.present?
		#alle Bunde mit Barcode
		@bundles = MeiserBundleTag.where(:deliver_reference_id => @meiser_delivery.deliver_reference_ids).includes(:weightings).order("barcode ASC")
		
		#Anzahl verwogene Bunde mit Barcode 
		@count_bundles_ready = MeiserBundleTag.where(:deliver_reference_id => @meiser_delivery.deliver_reference_ids).joins(:weightings).count(distinct: true)
		
		#alle Verwiegungen der Kommission, bereinigt nach Zeit, da Kommission mehrmals durchlaufen sein kann

		w = Weighting.where(:ref =>@meiser_delivery.tag).where("created_at > ?", @meiser_delivery.created_at)
		
		#alle Bunde die mit Kommission eingegeben wurden
		@bundles_without_barcode = w.where(:barcode => nil)
		
		#bisherige Summe bei der Verwiegung
		
		@sum_brutto = w.sum(:weight_brutto)
		@sum_netto = w.sum(:weight_netto)
		@sum_tara = w.sum(:weight_tara)
		@sum_raw = @bundles.sum(:weight_raw)
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
		format.html
	end
	
  end

end

