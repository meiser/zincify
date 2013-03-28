class BaanGrid < Netzke::Basepack::Grid
	css_configure do |c|
	
	end
	
	def configure(c)
		c.model = "NextFreeNumber"
		c.persistence = true
		c.title = I18n.t("activerecord.models.next_free_number")
		c.enable_column_filters = false
		c.enable_extended_search = false
		c.context_menu = false
		c.edit_in_form_available = false
		c.add_in_form_available = false
		c.advanced_search_available = false
		c.column_filters_available = false
		
		# Declaring columns
		c.height = 400
		c.columns = [
		  { :name => :name,
			:renderer => "uppercase",
			:width => 200,
			:read_only => false
		  },
		  :description,
		  { :name => :fifo,
			:width => 1100,
			:header =>  I18n.t("activerecord.attributes.next_free_number.fifo"),
		  }
		  #,
		  #{:name => :image, :getter => lambda{ |r| "<a href='#{r.image.url}'>Download</a>" if r.image.url }}
		]
		super
  end
  
  def default_bbar
	[:add, :edit, :apply]#[:show_details.action, "-", *super]
  end

end