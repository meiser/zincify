class Application < Netzke::Basepack::Viewport
  include Netzke::Basepack::ItemPersistence

  HEADER_HTML = 'Meiser Verzinkerei Plauen GmbH & Co. KG'

  js_configure do |c|
    c.layout = :border
    c.padding = 0
	  c.init_component = <<-JS
      function(){
        // Call parent
		this.callParent();
		//alert("Call window");
      }
    JS
    c.on_settings = <<-JS
      function(){
      //this.netzkeLoadComponent("window_with_settings");
      //  this.netzkeLoadComponent("window_with_settings", {container: this.mainPanel, callback: function(cmp) {
      //    cmp.show();
      //  });
        this.netzkeLoadComponent("window_with_settings",{container: this.mainPanel, callback: function(cmp){cmp.show();}});
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
				{html: HEADER_HTML}#, :about, :sign_out, :sign_in}
			]
		},
		{component: :zincify_tab_panel}
    #{
    #  region: :south,
    #  bbar: [
    #    :settings
    #  ]
    #}
    ]
	  
  end


  component :window_with_settings do |c|
    c.region = :center
  end

  #
  # Component declarations
  #
 
  component :zincify_tab_panel do |c|
   c.region = :center
  end
   
  action :settings do |c|
    c.text = "Belegnummernkreise"
    c.tooltip =  "Belegnummernkreise verwalten"
    c.icon = :cog
  end
  
  action :about do |c|
    c.icon = :information
  end

  action :sign_in do |c|
    c.icon = :door_in
  end

  action :sign_out do |c|
    c.icon = :door_out
  end
  
  
end