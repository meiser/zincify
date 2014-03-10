class WeightingController < ApplicationController

 before_filter :parse_time
 
 def index

 end
 
 def new

 end
 
 def print
 
 end
 
 def calc
   #@weightings = Weighting.select("sum(weight_netto)").where(:created_at => @list_date.beginning_of_day..@list_date.end_of_day).includes(:sort_list).group(:sort_list_id)
   #render :text => "#{@weightings.count}"
   @weightings = Weighting.select("Count(*) as occ, sort_list_id, sum(weight_brutto) as weight_brutto, sum(weight_tara) as weight_tara, sum(weight_netto) as weight_netto, weight_unit as weight_unit").where(:created_at => @list_date.beginning_of_day..@list_date.end_of_day).group(:sort_list_id, :weight_unit).includes(:sort_list).reorder("sort_list_id ASC")
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
				:cell_style => { :size => 8, :align => :right } do
				row(0).font_style = :bold	
			end
		end
		
		send_data pdf.render, filename: "TageslisteVerwiegungenSchicht#{@selected_shift.description}_#{@selected_shift.date.strftime("%Y%m%d")}.pdf",
                          type: "application/pdf",
                          disposition: "inline"
	end
 end
  
 end
  
 private
 
 def parse_time
  @list_date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]} 22:00")
 end
 

end
