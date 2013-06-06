class WeightingForm < Netzke::Basepack::Form

  js_configure do |c|
   c.mixin
   c.init_component = <<-JS
      function(){
	    // calling superclass's initComponent
        this.callParent();
		this.on('submitsuccess', function(){
			alert("Etikett wird gedruckt");
			
			this.getForm().findField("id").reset();
			this.getForm().findField("barcode").reset();
			this.getForm().findField("ref").reset();
			
			//this.getForm().findField("shift").reset();
			//this.getForm().findField("weight_brutto").reset();
			
			this.getForm().findField("weight_tara").reset();
			this.items.items[1].focus();
		});
		this.on('afterrender', function(form){
			form.items.items[1].focus();
		});
	  }
    JS
  end

  def configure(c)
  
	c.model = "Weighting"
	c.width = 400
	c.items= [
		{
			:name => :barcode,
			:width => 200
		},
		{
			:name => :ref,
			:field_label => "Kommission",
			:width => 200
		},
			{
			:name => :pid,
			:read_only => false,
			:field_label => "Personalkennnung",
			:width => 200
		},
		{
			:name => :sort_list__search_string,
			:minChars => 1,
			:eager_loading => true
		},
		{
			:name => :weight_tara,
			:width => 400,
			:read_only => false
		},
	]
  	super(c)
  end
    
  endpoint :netzke_submit do |params, this|
	begin
		data = ActiveSupport::JSON.decode(params[:data])
		# adding weight to form params
		# printing label is done in observer
		data["ref"] = nil if data["barcode"].present?
		
		# connection to scale
		scale=Rhewa82::Comfort.new("172.17.206.160",8000)
		data["scale_ident"] = scale.ident unless data["weight_brutto"].present?
		data["weight_unit"] = scale.unit unless data["weight_brutto"].present?
		data["weight_brutto"] = scale.brutto unless data["weight_brutto"].present?
		data["weight_tara"] = scale.tara unless data["weight_tara"].present?
		params[:data] = ActiveSupport::JSON.encode(data)
		# call parent
		super(params,this)		
	rescue
		this.netzke_feedback("Verbindung zur Waage ist gestört. Wiegedaten wurden nicht abgespeichert und es wird kein Etikett gedruckt.")
		#params[:data] = ActiveSupport::JSON.encode({})
	end
	
	
  end
  
end