class WeightingController < ApplicationController

 include ActionView::Helpers::NumberHelper
 include ApplicationHelper
 include ActionView::Helpers::OutputSafetyHelper
 include ActionView::Helpers::TextHelper

 
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
   
   @meiser_deliveries = MeiserDelivery.unscoped.where(:indate => @indate).order("created_at ASC")
   commission_list = @meiser_deliveries.pluck(:tag)
   #@weightings = Weighting.select("Count(*) as occ, item_base_data_id, sum(weight_brutto) as weight_brutto, sum(weight_tara) as weight_tara, sum(weight_netto) as weight_netto, weight_unit as weight_unit").where(:created_at => @indate..@indate+30.days).where(ref: commission_list).group(:item_base_data_id, :weight_unit).includes(:item_base_data).reorder("item_base_data_id ASC")
   @weightings = Weighting.unscoped.select("Count(*) as occ, ref, item_base_data_id, sum(weight_brutto) as weight_brutto, sum(weight_tara) as weight_tara, sum(weight_netto) as weight_netto, weight_unit as weight_unit").where(:created_at => @indate..@indate+30.days).where(ref: commission_list).group(:item_base_data_id, :ref, :weight_unit).includes(:item_base_data).order("item_base_data_id ASC")
   
   #Sortierung nach Artikelnummer aufsteigend
   @weightings = @weightings.sort_by{|w| w.item_base_data.try(:item)|| ""}
   
   w = Weighting.where(:created_at => @indate..@indate+30.days).where(ref: commission_list)
   @sum_brutto = w.sum(:weight_brutto)
   @sum_tara = w.sum(:weight_tara)
   @sum_netto = w.sum(:weight_netto)
   
   
   #Rohgewicht
   ref_ids = @meiser_deliveries.includes(:deliver_references).map(&:deliver_reference_ids).flatten

   @bundles = MeiserBundleTag.where(:deliver_reference_id => ref_ids).includes(:weightings).order("barcode ASC")
   @sum_raw = @bundles.sum(:weight_raw)
   
   
   #w = Weighting.where(:ref =>@meiser_delivery.tag).where(:created_at => @meiser_delivery.created_at..@meiser_delivery.created_at+30.days)
   #commission_ids = @meiser_deliveries.map(&:tag)	
   #@weightings_per_commission = 
   
   respond_to do |format|
	format.html do
		render :layout => "weight_list"
	end
	format.pdf do
	
		pdf = Prawn::Document.new(
			page_size: "A4",
			page_layout: :landscape,
			margin: [100,20,10,20]
		)
		pdf.text "Abrechnung Meiser Vogtland OHG #{l @indate, :format => :coupon }, #{@meiser_deliveries.count} Kommission(en)"
		pdf.text " "
		items = []
		kommissionen = @meiser_deliveries.map(&:tag)
		items << ["Kommission","Netto"]+kommissionen
	
		unless @weightings.empty?
			weight_per_kommission = Array.new(kommissionen.length+2,0)
			@weightings.group_by(&:item_base_data).each do |i,weightings|
				row = Array.new(kommissionen.length+2,"")
				kg = 0
				#Artikel
				row[0] = truncate("#{i.item if i.present?} #{i.description if i.present?}",length: 25)
				
				weightings.each do |w|
					kg+=w.weight_netto
					weight_per_kommission[kommissionen.index(w.ref)+2] +=w.weight_netto
					row[kommissionen.index(w.ref)+2] = "#{number_to_currency(w.weight_netto, unit: "", precision: 0)}"
				end
				row[1]= "#{number_to_currency(kg, unit: "", precision: 0)}"
				
				items << row
			end
			
			#Anzeige Gewicht pro Kommission
			tmp = []
			tmp << {:content => "Summe:", :font_style => :bold}
			tmp << {:content => "#{number_to_currency(@sum_netto.round, unit: "", precision: 0)}", :font_style => :bold}
			
			weight_per_kommission.each_with_index do |weight,i|
				if i > 1
					tmp << {content: "#{number_to_currency(weight.round, unit: "", precision: 0)}", :font_style => :bold}
				end
			end
			
			items << tmp

			#items << [
			#	{:content =>  "Zinkauflage bei roh #{number_to_currency(@sum_raw.round, unit: "", precision: 0)}", :font_style => :bold},
			#	{:content => "#{za(@sum_raw, @sum_netto)} %", :font_style => :bold}
			#]
			
		end


		unless items.empty?
			pdf.table items, :header => true,
				:row_colors => ["FFFFFF", "E1EEf4"],
				:cell_style => { :size => 10, :align => :right, :padding => [3,5,3,5] } do
					row(0).font_style = :bold
					column(1).font_style = :bold
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
