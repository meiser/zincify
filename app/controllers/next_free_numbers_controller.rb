class NextFreeNumbersController < ApplicationController

 def index
	respond_to do |format|
		format.html
	end
 end
 
 def new
	@next_free_number = NextFreeNumber.new
 end
 
 def create
	@next_free_number = NextFreeNumber.new(params[:delivery])
	
	respond_to do |format|
      if @next_free_number.save
        format.html { redirect_to @next_free_number, notice: t("next_free_numbers.created") }
        format.json { render json: @next_free_number, status: :created, location: @next_free_number }
      else
        format.html { render action: "new" }
        format.json { render json: @next_free_number.errors, status: :unprocessable_entity }
      end
    end
 end
 
 def show
  
 end

end
