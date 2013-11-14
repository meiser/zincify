class MeiserDeliveryGrid < DeliveryGrid
   
  js_configure do |c|
   c.force_fit = true
   
   
   c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		this.on("selectionchange",function(selModel){
			this.actions.listDetailsExcel.setDisabled(selModel.getCount() > 1);
		});
      }
    JS
   
   # handler for the 'list details' action
   c.on_list_details_excel = <<-JS
      function(m,r){
		grid = this;
		Ext.iterate(this.getSelectionModel().getSelection(),function(key,value){
			window.open("meiser_deliveries/"+key.data.id+".xls");
		});
		
      }
    JS
  end
  
  
  action :list_details_excel do |c|
    c.icon = :page_white_excel
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
	c.tbar = [:add, :del, :edit, :list_details_excel]
	c.bbar = []
   
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
 
  
end