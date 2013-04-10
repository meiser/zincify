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
	c.active_tab = 2
	c.minHeight = 600
	c.items = [:all_deliveries, :meiser_deliveries, :customer_deliveries, :cash_payer_deliveries]
  end
  
  component :all_deliveries do |c|
   c.klass = DeliveryGrid
   c.title = I18n.t("netzke.titles.all_deliveries")
   c.enable_edit_in_form = false
   c.enable_context_menu = false
   c.enable_column_filters = false
   c.enable_edit_inline = false
   c.context_menu = nil
   c.menu = nil
   c.actions = []
  end
  
  component :meiser_deliveries do |c|
   c.klass = MeiserDeliveryGrid
   c.strong_default_attrs = {:customer_id => 1}
   c.title = I18n.t("netzke.titles.meiser_deliveries")
   c.scope = {:customer_id => 1 } 
  end
  
  component :customer_deliveries do |c|
   c.klass = CustomerDeliveryGrid
   c.title = I18n.t("netzke.titles.customer_deliveries")
   #c.scope = ["customer_id <> ?", 1]
   c.scope = "customer_id <> 1 and customer_id <> 142"
  end
  
  component :cash_payer_deliveries do |c|
   c.klass = CashPayerDeliveryGrid
   c.strong_default_attrs = {:customer_id => 142}
   c.title = I18n.t("netzke.titles.cash_payer_deliveries")
   c.scope = "cash_payer_id IS NOT NULL"
  end
 
end