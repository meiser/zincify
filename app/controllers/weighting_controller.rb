﻿class WeightingController < ApplicationController

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
  @list_date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]} 22:00")
  if params[:shift].present?
      @selected_shift = Shift.new(params[:shift],@list_date)
	  @shift = params[:shift]
	  
	  # alle Wiegungen inklusive Zink
	  regular_weightings = Weighting.where(:created_at => @selected_shift.start_time..@selected_shift.end_time).includes(:sort_list)
	  @weightings = regular_weightings.where("sort_list_id <>36")
	  @sum = @weightings.sum(:weight_netto)
	  
	  # Nur Hartzinkverwiegungen
	  @zink_weightings = regular_weightings.where("sort_list_id = 36")
	  
	  render :layout => "weight_list"
	  #render :text => "#{l @shift_time[0]} bis #{l @shift_time[1]}"
  else
      render :text => "Aufruf nicht korrekt"
  end
 end

end
