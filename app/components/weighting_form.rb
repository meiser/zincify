class WeightingForm < Netzke::Basepack::Form

  js_configure do |c|
   c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		this.on('submitsuccess', function(){
			alert("Etikett wird gedruckt");
			this.getForm().reset();
			this.items.items[1].focus();
			//window.location.reload();
		});
		this.on('afterrender', function(form){
			console.log(form.items.items[1].focus());
		});
	  }
    JS
  end

  def configure(c)
  	super(c)
    c.model = "Weighting"
	c.width = 400
	c.items = [
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
			:name => :shift,
			:field_label => "Schicht",
			:read_only => false,
			:width => 200
		},
		{
			:name => :sort_list__search_string,
			:minChars => 1
		},
		{
			:name => :weight_brutto,
			:width => 400,
			:read_only => false
		},
		{
			:name => :weight_tara,
			:width => 400,
			:read_only => false
		}#,
		#{
		#	:name => :weight_netto,
		#	:width => 400,
		#	:read_only => true,
		#	:value => 0
		#}
	]

  end
  
end