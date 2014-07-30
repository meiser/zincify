class WeightingController < ApplicationController

 before_filter :parse_time, :except => [:calc]
 
 def index

 end
 
 def new

 end
 
 def print
 
 end
 
 def calc
 
   begin
	@indate = Date.new(params[:year].to_i,params[:month].to_i,params[:day].to_i)
   rescue
	@indate = Date.today
   end
   #@weightings = Weighting.select("sum(weight_netto)").where(:created_at => @list_date.beginning_of_day..@list_date.end_of_day).includes(:sort_list).group(:sort_list_id)
   #render :text => "#{@weightings.count}"
   #@weightings = Weighting.select("Count(*) as occ, sort_list_id, sum(weight_brutto) as weight_brutto, sum(weight_tara) as weight_tara, sum(weight_netto) as weight_netto, weight_unit as weight_unit").where(:created_at => @list_date.beginning_of_day..@list_date.end_of_day).group(:sort_list_id, :weight_unit).includes(:sort_list).reorder("sort_list_id ASC")
   #@meiser_deliveries = MeiserDelivery.where(:created_at => @list_date.beginning_of_day..@list_date.end_of_day)
   
   @meiser_deliveries = MeiserDelivery.where(:indate => @indate)
   commission_list = @meiser_deliveries.pluck(:tag)
   @weightings = Weighting.select("Count(*) as occ, item_base_data_id, sum(weight_brutto) as weight_brutto, sum(weight_tara) as weight_tara, sum(weight_netto) as weight_netto, weight_unit as weight_unit").where(:created_at => @indate..@indate+30.days).where(ref: commission_list).group(:item_base_data_id, :weight_unit).includes(:item_base_data).reorder("item_base_data_id ASC")
   w = Weighting.where(:created_at => @indate..@indate+30.days).where(ref: commission_list)
   @sum_brutto = w.sum(:weight_brutto)
   @sum_tara = w.sum(:weight_tara)
   @sum_netto = w.sum(:weight_netto)
   respond_to do |format|
	format.html do
		render :layout => "weight_list"
	end
	format.pdf do
	
		pdf = Prawn::Document.new
		pdf.text "Abrechnung Meiser Vogtland OHG #{l @indate, :format => :coupon }, #{@meiser_deliveries.count} Kommission(en)"
		pdf.text " "
		
		items = []
		items << ["Nr", "Kommission", "Erstellungsdatum"]
		unless @meiser_deliveries.empty?
			@meiser_deliveries.each_with_index do |md,i|
				items <<
				[
					"#{i+1}",
					md.tag,
					"#{l md.created_at, :format => :coupon}"
				]
			end
		end
		
		pdf.table items, :header => true,
			:row_colors => ["FFFFFF", "E1EEf4"],
			:cell_style => { :size => 10, :align => :right, :padding => [3,10,3,10] } do
			row(0).font_style = :bold	
		end
		
		pdf.text " "
		
		items = []
		
		items << ["Nr", "Aritkel", "Artikelbezeichnung", "Netto"]
		
		unless @weightings.empty?

		
			@weightings.each_with_index do |w,i|
				items <<
				[
					i+1,
					"#{w.item_base_data.item if w.item_base_data.present?}",
					"#{w.item_base_data.description if w.item_base_data.present?}",
					"#{w.weight_netto} #{w.weight_unit}NE"
				]
			end
			
			items << [
				{:content => "Summe:", :colspan => 3, :font_style => :bold},
				"#{@sum_netto} #{@weightings.first.weight_unit}NE"
			]
			
		end
		

		unless items.empty?
			pdf.table items, :header => true,
				:row_colors => ["FFFFFF", "E1EEf4"],
				:cell_style => { :size => 10, :align => :right, :padding => [3,10,3,10] } do
				row(0).font_style = :bold	
			end
		end
		
		send_data pdf.render, filename: "AbrechnungMeiserVogtlandOHG_#{@indate.strftime("%d%m%Y")}.pdf",
                          type: "application/pdf",
                          disposition: "inline"
	end
	
	
	
	
   end
 end
 
 def list
  @shift = params[:shift]
  @selected_shift = Shift.new(@shift,@list_date)
	
  # alle Wiegungen exklusive Zink
  regular_weightings = Weighting.where(:created_at => @selected_shift.start_time..@selected_shift.end_time)
  @weightings = regular_weightings.where("sort_list_id <>36")
  @sum = @weightings.sum(:weight_netto)
	
  # Nur Hartzinkverwiegungen
  @zink_weightings = regular_weightings.where("sort_list_id = 36")
  @sum_zink = @zink_weightings.sum(:weight_netto)

  
  
  respond_to do |format|
	format.html do
		render :layout => "weight_list"
	end
	format.pdf do
	
		pdf = Prawn::Document.new
		pdf.text "Tagesliste Schicht #{ @selected_shift.description} #{l @selected_shift.start_time, :format => :coupon } bis #{l @selected_shift.end_time, :format => :coupon }"

		
		items = []
		
		items << ["Nr", "Datum", "PNr", "Schicht", "KomNr", "Sorte", "Brutto", "Tara", "Netto"]
		
		unless @weightings.empty?

		
			@weightings.each_with_index do |w,i|
				items <<
				[
					i+1,
					l(w.created_at, :format => :coupon),
					w.pid,
					w.shift,
					w.ref || w.barcode,
					w.sort_list.description,
					"#{w.weight_brutto} #{w.weight_unit}",
					"#{w.weight_tara} #{w.weight_unit}T",
					"#{w.weight_netto} #{w.weight_unit}NE"
				]
			end
			
			items << [
				{:content => "#{@weightings.count} Wiegung(en) mit Summe", :colspan => 8},
				"#{@sum} #{@weightings.first.weight_unit}"
			]
			
		end
		
		unless @zink_weightings.empty?
			items << [
				{:content => "ES WURDEN FOLGENDE HARTZINKVERWIEGUNGEN DURCHGEFÜHRT", :colspan => 9}
			]
			
			@zink_weightings.each_with_index do |w,i|
				items <<
					[
						i+1,
						l(w.created_at, :format => :coupon),
						w.pid,
						w.shift,
						w.ref || w.barcode,
						w.sort_list.description,
						"#{w.weight_brutto} #{w.weight_unit}",
						"#{w.weight_tara} #{w.weight_unit}T",
						"#{w.weight_netto} #{w.weight_unit}NE"
					]
			end
			
			
			items << [
				{:content => "#{@zink_weightings.count} Wiegung(en) mit Summe", :colspan => 8},
				"#{@sum_zink} #{@zink_weightings.first.weight_unit}"
			]
		end

		unless items.empty?
			pdf.table items, :header => true,
				:row_colors => ["FFFFFF", "E1EEf4"],
				:cell_style => { :size => 8, :align => :right, :padding => [1,10,1,10] } do
				row(0).font_style = :bold	
			end
		end
		
		send_data pdf.render, filename: "TageslisteVerwiegungenSchicht#{@selected_shift.description}_#{@selected_shift.date.strftime("%Y%m%d")}.pdf",
                          type: "application/pdf",
                          disposition: "inline"
	end
 end
  
 end
  
 def item
	params[:weighting_ids].each_with_index do |id,j|
		@weighting = Weighting.find(id)
		@item_base_data = ItemBaseData.find(params[:item_base_data_ids][j])
		@weighting.update_column(:item_base_data_id, @item_base_data.id)
	end
	render :nothing => true
 end 
 
 private
 
 def parse_time
  @list_date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]} 22:00")
 end
 

end
