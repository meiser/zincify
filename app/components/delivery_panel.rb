class DeliveryPanel < Netzke::Basepack::TabPanel

  js_configure do |c|
    c.force_fit = true
	c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		this.on('tabchange', function(p,n,o){
			n.items.each(function(item){ 
				item.getStore().load();
			});  
		});
      }
    JS
  end
  
  def configure(c)
   super(c)
	 c.active_tab = 0
	 c.minHeight = 600
	 c.items = [:meiser_deliveries, :customer_deliveries, :cash_payer_deliveries]
  end
  
  #component :all_deliveries do |c|
  # c.klass = DeliveryGrid
  # c.title = I18n.t("netzke.titles.all_deliveries")
  # c.enable_edit_in_form = false
  # c.enable_context_menu = false
  # c.enable_column_filters = false
  # c.enable_edit_inline = false
  # c.context_menu = [:print_card]
  # c.menu = [:print_card]
  # c.tbar = [:print_card]
  # c.bbar = [:print_card]
  # c.actions = []
  #end
  
  component :meiser_deliveries do |c|
   c.klass = MeiserDeliveryGrid
   c.model = "MeiserDelivery"
   c.title = I18n.t("netzke.titles.meiser_deliveries")
  end
  
  component :customer_deliveries do |c|
   c.klass = CustomerDeliveryGrid
   c.model = "CustomerDelivery"
   c.title = I18n.t("netzke.titles.customer_deliveries")
  end
  
  component :cash_payer_deliveries do |c|
   c.klass = CashPayerDeliveryGrid
   c.model = "CashPayerDelivery"
   c.title = I18n.t("netzke.titles.cash_payer_deliveries")
  end
 
end