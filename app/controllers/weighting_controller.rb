class WeightingController < ApplicationController

 protect_from_forgery
 
 respond_to :json, :only => :poll

 def index

 end
 
 def new
 
 end
 
 def print
 
 end
 
 def sum
   
 end
 
 def list
  @list_date = Date.civil(params[:year].to_i, params[:month].to_i, params[:day].to_i)
  if params[:shift].present?
      @selected_shift = Shift.new(params[:shift],@list_date)
	  @shift = params[:shift]
	  @weightings = Weighting.where("sort_list_id <>36").where(:created_at => @selected_shift.start_time..@selected_shift.end_time)
	  @sum = @weightings.sum(:weight_netto)
	  render :layout => "weight_list"
	  #render :text => "#{l @shift_time[0]} bis #{l @shift_time[1]}"
  else
      render :text => "Aufruf nicht korrekt"
  end
 end

end