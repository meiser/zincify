class WeightingController < ApplicationController

 protect_from_forgery
 
 respond_to :json, :only => :poll

 def index

 end
 
 def new
 
 end
 
 def print
 
 end
 
 def list
  @list_date = DateTime.civil(params[:year].to_i, params[:month].to_i, params[:day].to_i)
  if params[:shift].present?
  	  @shift_time = case params[:shift]
	  when "1"
		[@list_date.change(:hour => 6), @list_date.change(:hour => 14)]
	  when "2"
		[@list_date.change(:hour => 14), @list_date.change(:hour => 22)]
	  when "3"  
		[@list_date.change(:hour => 22), @list_date.change(:day =>@list_date.day.next, :hour => 6)]
	  end
	  @weightings = Weighting.where(
		:shift => params[:shift],
		:created_at => (@shift_time[0]..@shift_time[1])
	  )
	  #render :text => "#{l @shift_time[0]} bis #{l @shift_time[1]}"
  else
      render :text => "Aufruf nicht korrekt"
  end
 end

end