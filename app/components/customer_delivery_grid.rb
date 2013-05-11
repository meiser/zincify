class CustomerDeliveryGrid < DeliveryGrid

  js_configure do |c|
	c.on_print_card = <<-JS
      function(){
		grid = this;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			Rails.CustomerDeliveriesController.print({"id": key.data.id}, function(r,e){
				if (r.success == true){
					Ext.Msg.show({
					  title: r.title,
					  width: 300,
					  msg: r.message,
					  buttons: Ext.Msg.OK,
					  icon: Ext.MessageBox.INFO
					});
				} else {
					alert(r.success);
				}
			});
		});
		
      }
    JS
  end
  
  def configure(c)
   super(c)
   c.columns = [
		{
			:name => :commission,
			:width => 200,
			:read_only => true
		},
		{
			:name => :customer__bpid,
			:read_only => true,
			:minChars => 1
		},
		{
			:name => :customer__search_string,
			:width => 400,
			:minChars => 1
		},
		{
			:name => :tag,
			:width =>200
		},
		{
			:name => :indate,
			:width => 100
		},
		{
			:name => :outdate,
			:width => 100
		},
		{
			:name => :remarks,
			:width => 300,
			:getter => lambda{|r| CGI::escapeHTML(r.remarks || "")}
		},
		{
			:name => :created_at,
			:width => 200
		},
		{
			:name => :updated_at,
			:width => 200
		}
	]
  end
  

  component :add_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.new_customer_delivery")
   c.form_config.items = [
		{
			:name => :customer__search_string,
			:minChars => 1
		},
		{
			:name => :tag
		},
		{
			:name => :indate,
			:width => 100,
			:getter => lambda{|r| I18n.l(DateTime.now, :format => :short)}
		},
		{
			:name => :outdate,
			:width => 100,
			:getter => lambda{|r| I18n.l(DateTime.now+1.day, :format => :short)}

		},
		{
			:name => :remarks,
			:width => 100
		}
   ]
  end
  
  component :edit_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.edit_delivery")
   c.form_config.items = [
		{
			:name => :commission,
			:disabled => true
		},
		{
			:name => :tag
		},
		{
			:name => :customer__search_string,
			:disabled => true
		},
		{
			:name => :indate,
			:width => 100,
			:getter => lambda{|r| r.indate.strftime("%d.%m.%Y")}# I18n.l(r.indate, :format => :short)}
		},
		{
			:name => :outdate,
			:width => 100,
			:getter => lambda{|r| r.outdate.strftime(I18n.t("time.formats.short"))}
		},
		{
			:name => :remarks,
			:width => 100
		}
   ]
  end
  
  #def columns
	#super - [:state, :reference, :cash_payer_name]
  #end

end