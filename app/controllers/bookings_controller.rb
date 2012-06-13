class BookingsController < ApplicationController

  respond_to :mobile


  def index
   @bookings = Booking.order("created_at asc").page(params[:page]).per(10)
  end

  def new
    @booking = Booking.new
    @traverses = Traverse.with_state(:unbooked)
    @deliveries = Delivery.with_state(:captured)
  end

  def create

    deliveries = params[:booking].delete(:delivery_id).delete_if{|d| d.empty?}

    deliveries.each do |delivery|
     b=Booking.new(params[:booking])
     b.delivery_id=delivery
     b.save
    end


    redirect_to new_booking_path, :notice => "Traversenbuchung erfolgreich abgeschlossen"
    #render :text => params
  end


end

