class MeiserDeliveryGrid < DeliveryGrid
   
  js_configure do |c|
   c.force_fit = true
   
   
   c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		this.on("selectionchange",function(selModel){
			this.actions.listDetailsExcel.setDisabled(selModel.getCount() > 1);
			this.actions.listDetailsHtml.setDisabled(selModel.getCount() > 1);
			this.actions.setItems.setDisabled(selModel.getCount() > 1);
			this.actions.listBill.setDisabled(selModel.getCount() > 1);
		});
      }
    JS
	
   # handler for the 'application_' action
   c.on_set_items = <<-JS
      function(m,r){
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			var win = new Ext.Window({  
				id: 'set_items_window',  
				autoScroll: true,				
				layout: 'fit',
				autoLoad: { 
					method: 'get',
					url : 'meiser_deliveries/'+key.data.id+'.html?item=1'  
				}
			});
			win.modal = true;			
			win.setTitle("Festlegen der Baan-Artikel für Kommission "+key.data.tag);
			win.height = Ext.getBody().getViewSize().height,
			win.width = Ext.getBody().getViewSize().width,
			win.show();
		});
      }
   JS
   
   
   # handler for the 'list details excel' action
   c.on_list_details_excel = <<-JS
      function(m,r){
		grid = this;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			window.open("meiser_deliveries/"+key.data.id+".xls");
		});
		
      }
    JS
   # handler for the 'list details html' action
   c.on_list_details_html = <<-JS
      function(m,r){
		grid = this;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			var win = new Ext.Window({  
				id: 'myWindow',  
				autoScroll: true,				
				layout: 'fit',
				autoLoad : { 
					method: 'get',
					url : 'meiser_deliveries/'+key.data.id+'.html'  
				}
			});
			win.modal = true;			
			win.setTitle("Überblick Kommission "+key.data.tag);
			win.height = Ext.getBody().getViewSize().height,
			win.width = Ext.getBody().getViewSize().width,
			win.show();
			
			
			//grid.netzkeLoadComponent("WeightingListPrintDialog", {container: grid, callback: function(cmp) {
			//	//this.updateInfo(cmp.desc);
			//	if (cmp.isFloating()) { 
			//		cmp.modal = true;
			//		cmp.show(); 
			//	}
			//}, scope: this});
		});
		
      }
    JS
	# handler for the 'print card' action
	c.on_print_card = <<-JS
      function(){
		grid = this;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			Rails.MeiserDeliveriesController.print_commission({"id": key.data.id}, function(r,e){
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
	
	c.on_list_bill = <<-JS
      function(a){
		var delivery_date;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			delivery_date = key.data.indate;
			
		});
		
		this.netzkeLoadComponent("bill_form_window", {
			container: "application__zincify_tab_panel",
			configOnly: false,
			callback: function(w){
				w.modal = true;
				var form = w.down("form");
				form.getForm().setValues({
					delivery_date: delivery_date
				});
				w.show();
			}
		});
      }
    JS
	
  end
  
  component :bill_form_window do |c|
	c.region = :north
  end
  
  action :list_bill do |c|
	c.icon = :calculator
	c.disabled = false
  end
  
  action :set_items do |c|
    c.icon = :application_form
	c.disabled = true
  end
  
  action :list_details_html do |c|
    c.icon = :information
	c.disabled = true
  end
  
  component :weighting_list_print_dialog
  
  action :list_details_excel do |c|
    c.icon = :page_white_excel
	c.disabled = true
  end
  
  action :print_card do |c|
    c.icon = :printer
	c.disabled = true
  end
  
  def configure(c)
  	super(c)
    c.model = "MeiserDelivery"
	c.columns = [
		#{
		#	:name => :commission,
		#	:width => 200,
		#	:read_only => true
		#},
		{
			:name => :tag,
			:width => 200,
			:read_only => true
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
	c.tbar = [:add, :del, :edit, :list_details_html, :print_card]#, :list_details_excel]
	c.bbar = [:set_items, :list_bill]
   
  end
  

  component :add_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.new_meiser_delivery")
   c.form_config.items = [
		{
			:name => :tag,
			:width => 200
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
			:name => :tag,
			:width => 200
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
  
  def default_context_menu
	[:list_details_html,:set_items, :list_bill,*super]
  end
  
end