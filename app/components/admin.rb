class Admin < Netzke::Basepack::Viewport
  include Netzke::Basepack::ItemPersistence

  HEADER_HTML = 'Meiser Verzinkerei Plauen GmbH & Co. KG Administration'

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
		:next_free_numbers
    #{
    #  region: :south,
    #  bbar: [
    #    :settings
    #  ]
    #}
    ]
	  
  end


  component :next_free_numbers do |c|
    c.region = :center
	c.klass = Netzke::Basepack::Grid
	c.model = "NextFreeNumber"
	c.title = "Belegnummernkreise"
	c.force_fit = true
  end

  
  
end