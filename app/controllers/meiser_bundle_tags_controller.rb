class MeiserBundleTagsController < ApplicationController

  layout 'mobile'
  
  def index
		@dr = DeliverReference.find(params[:deliver_reference_id])
		@meiser_bundle_tags = @dr.meiser_bundle_tags
  end
  
  def new
		@dr = DeliverReference.find(params[:deliver_reference_id])
		@dr = DeliverReference.find(params[:deliver_reference_id])
		@number_bundles = @dr.meiser_bundle_tags.count
		@meiser_bundle_tag = MeiserBundleTag.new
  end
  
  def create
		@dr = DeliverReference.find(params[:deliver_reference_id])
		@meiser_bundle_tag = MeiserBundleTag.new(params[:meiser_bundle_tag])
		@meiser_bundle_tag.deliver_reference = @dr
		if @meiser_bundle_tag.valid?
			@meiser_bundle_tag.save
			@number_bundles = @dr.meiser_bundle_tags.count
			#redirect_to new_deliver_reference_meiser_bundle_tag_path(@dr)
		else
			
			if @meiser_bundle_tag.barcode.present?
			
				@already_meiser_bundle_tag = MeiserBundleTag.where(:barcode => @meiser_bundle_tag.barcode).first
				@already_dr = @already_meiser_bundle_tag.deliver_reference
				
				render :already_scanned
			else
				render :js => "window.location.href='"+new_deliver_reference_meiser_bundle_tag_path(@dr, :format => :html)+"'"
				#redirect_to new_deliver_reference_meiser_bundle_tag_path(@dr, :format => :html)
			end
			
			#@js = "alert('Bereits vergeben')" # or whatever set of js statements needed
		end
  end
  
  def update
	@meiser_bundle_tag = MeiserBundleTag.find(params[:id])
	
	@dr = DeliverReference.find(params[:new_deliver_reference_id])
	
	@meiser_bundle_tag.deliver_reference = @dr
	
	#Speicherung neuen Anlieferungsreferenz für jeden Bund
	#Änderung Eintrag Kommission bei jeder Verwiegung, alles als Transaktion
	begin
		ActiveRecord::Base.transaction do
			@meiser_bundle_tag.save!
			@meiser_bundle_tag.weightings.each do |w|
				w.ref = @dr.meiser_delivery.tag
				w.save!
			end
		end
	rescue
		render :js => "alert('Aktion kann nicht ausgeführt werden, da bereits Verwiegungen existieren. Kontaktieren Sie ihren Systembetreuer!');"
		return
	end
	@number_bundles = @dr.meiser_bundle_tags.count
	render :create
  end
  
  def destroy
	@meiser_bundle_tag = MeiserBundleTag.find(params[:id])
	@dr = DeliverReference.find(params[:deliver_reference_id])
	
	@meiser_bundle_tag.destroy
	
	redirect_to deliver_reference_meiser_bundle_tags_path(@dr)
  end

end

