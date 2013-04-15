class CashPayerDeliveryGrid < DeliveryGrid
  
  js_configure do |c|
	c.on_print_card = <<-JS
      function(){
		grid = this;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			Rails.CashPayerDeliveriesController.print({"id": key.data.id}, function(r,e){
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
			:read_only => true,
			:filterable => true,
			:sortable => true,
		},
		{
			:name => :customer__bpid,
			:read_only => true,
			:filterable => true,
			:sortable => true
		},
		{
			:name => :customer__search_string,
			:width => 400,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :custom_name
		},
		{
			:name => :tag,
			:width =>200,
			:filterable => true,
			:sortable => true
		},
		{
			:name => :indate,
			:width => 100,
			:filterable => true,
			:sortable => true
		},
		{
			:name => :outdate,
			:width => 100,
			:filterable => true,
			:sortable => true
		},
		{
			:name => :remarks,
			:width => 300,
			:filterable => true,
			:sortable => true,
			:getter => lambda{|r| CGI::escapeHTML(r.remarks || "")}
		},
		{
			:name => :created_at,
			:width => 200,
			:filterable => true,
			:sortable => true
		},
		{
			:name => :updated_at,
			:width => 200,
			:filterable => true,
			:sortable => true
		}
	]
  end

  def configure(c)
	c.columns = [
		{
			:name => :commission,
			:width => 200,
			:read_only => true,
			:filterable => false,
			:sortable => false,
		},
		{
			:name => :cash_payer__search_string,
			:width => 200,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :custom_name
		},
		{
			:name => :tag
		},
		{
			:name => :indate,
			:width => 100,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :outdate,
			:width => 100,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :remarks,
			:width => 300,
			:filterable => false,
			:sortable => false,
			:getter => lambda{|r| CGI::escapeHTML(r.remarks)}
		},
		{
			:name => :created_at,
			:width => 200,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :updated_at,
			:width => 200,
			:filterable => false,
			:sortable => false
		}
	]
	super(c)
  end
  
  component :add_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.new_cash_payer_delivery")
   c.form_config.items = [
		#{
		#	:name => :customer__search_string,
		#	:scope => "bpid = 280000142"
		#},
		{
			:name => :cash_payer__search_string,
			:width => 300
		},
		{
			:name => :custom_name,
			:disabled => false
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
			:name => :cash_payer__name,
			:disabled => true
		},
		{
			:name => :cash_payer__address,
			:disabled => true
		},
		{
			:name => :custom_name,
			:disabled => false
		},
		{
			:name => :tag
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

  def columns
	[
		:commission,
		:cash_payer__search_string,
		:custom_name,
		:tag,
		:indate,
		:outdate,
		:remarks,
		:created_at,
		:updated_at	
	]
  end
  
end