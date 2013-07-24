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
	
  render :layout => "weight_list"
 end
  
 private
 
 def parse_time
  @list_date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]} 22:00")
 end
 

end
