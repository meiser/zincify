class ScannerWaageController < ApplicationController

  
  skip_before_filter :verify_authenticity_token
 

  def categories
	render :json => SortList.all.as_json(
      only: [:id, :number, :description]
	)
  end
  
  def new_weighting
  
	@weighting = Weighting.new
	@weighting.barcode = params[:barcode]
	@weighting.pid = params[:pid]
	
	scale=Rhewa82::Comfort.new("172.17.206.160",8000)
	
	@weighting.scale_ident = scale.ident unless params[:weight_brutto].present?
	@weighting.weight_unit = scale.unit unless params[:weight_brutto].present?
	@weighting.weight_brutto = scale.brutto unless params[:weight_brutto].present?
	@weighting.weight_brutto = 430 if Rails.env.development?
	@weighting.weight_tara = params[:weight_tara] ||= scale.tara 
	@weighting.sort_list_id = params[:sort_list]
	
  
	if @weighting.save
		render :text => "OK"
	else
  
		render :text => @weighting.errors.to_json
	end
  end
  
end

