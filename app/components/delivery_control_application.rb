class DeliveryControlApplication < Netzke::Basepack::Viewport
include Netzke::Basepack::ItemPersistence

  HEADER_HTML = 'Warenannahme Meiser Verzinkerei Plauen GmbH & Co. KG'

  js_configure do |c|
   c.layout = :border
   c.init_component = <<-JS
	function(){
		this.callParent();
    }
   JS
  end

  def configure(c)
    super(c)
    c.items = [
		{
			item_id: :main_panel,
			region: :north,
			tbar: [
				{html: HEADER_HTML}
			]
		},
		{component: :delivery_panel}
    ]
	  
  end
  
  component :delivery_panel do |c|
   c.region = :center
   c.items = [:weighting_monitor]
  end
  
  component :weighting_monitor

  
end