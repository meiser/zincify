class AdminApplication < Netzke::Basepack::Viewport
  include Netzke::Basepack::ItemPersistence

  HEADER_HTML = 'Meiser Verzinkerei Plauen GmbH & Co. KG Administration'

  js_configure do |c|
    c.layout = :border
    c.padding = 0
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
		{component: :admin_panel}
    #{
    #  region: :south,
    #  bbar: [
    #    :settings
    #  ]
    #}
    ]
	  
  end
 
  component :admin_panel do |c|
   c.region = :center
  end

end