class WeightingForm < Netzke::Basepack::Form

  js_configure do |c|
   c.init_component = <<-JS
      function(){
		var pollScale = new Ext.direct.PollingProvider({
			type:'polling',
			url: 'poll',
			interval: 10000
		});
		//Ext.direct.Manager.addProvider(pollScale);
		//pollA.disconnect();
		//Ext.Direct.on('scale_polling', function(e){
		//	console.log(e.data);
		//});
		
		Rails.WeightingController.poll(function(r,e){
			console.log(r.data);
		});
		
        // calling superclass's initComponent
        this.callParent();
		this.on('submitsuccess', function(){
			alert("Etikett wird gedruckt");
			//Ext.Msg.show({
			//		  title: "Info",
			//		  width: 300,
			//		  msg: "Etikett wird gedruckt",
			//		  buttons: Ext.Msg.OK,
			//		  icon: Ext.MessageBox.INFO
			//});
			this.getForm().findField("id").reset();
			this.getForm().findField("barcode").reset();
			this.getForm().findField("ref").reset();
			this.getForm().findField("weight_brutto").reset();
			this.getForm().findField("weight_tara").reset();
			//this.getForm().reset();
			this.items.items[1].focus();
			//window.location.reload();
		});
		this.on('afterrender', function(form){
			form.items.items[1].focus();
		});
	  }
    JS
  end

  def configure(c)
  
	#@sort_lists = []
	#SortList.all.each do |s|
	# @sort_lists.append [s.number,s.description]	
	#end  

	#p @sort_lists
    
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
  	super(c)
  end
  
  endpoint :netzke_submit do |params, this|
	begin
		data = ActiveSupport::JSON.decode(params[:data])
		# adding weight to form params
		# printing label is done in observer
		data["ref"] = nil if data["barcode"].present?
		
		# connection to scale
		s =TCPSocket.new("172.17.206.160",8000)
		s.puts "<FP>"

		line = s.gets
		scale=CSV.parse_line(line, {:col_sep => ";"})
		
		#"Wiegenummer #{scale[1]}"
		#"Brutto #{scale[8]}"
		#"Tara #{scale[9]}"
		#"Einheit Gewicht #{scale[7]}"
		
		data["scale_ident"] = scale[1] unless data["weight_brutto"].present?
		data["weight_unit"] = scale[7] unless data["weight_brutto"].present?
		data["weight_brutto"] = scale[8] unless data["weight_brutto"].present?
		data["weight_tara"] = scale[9] unless data["weight_tara"].present?
		params[:data] = ActiveSupport::JSON.encode(data)
		# call parent
		super(params,this)		
	rescue
		this.netzke_feedback("Verbindung zur Waage ist gestört. Wiegedaten wurden nicht abgespeichert und es wird kein Etikett gedruckt.")
		#params[:data] = ActiveSupport::JSON.encode({})
	end
	
	
  end
  
end