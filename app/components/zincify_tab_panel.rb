class ZincifyTabPanel < Netzke::Basepack::TabPanel

  component :delivery_panel do |c|
   c.title = I18n.t("activerecord.models.delivery")
  end
  
  def configure(c)
  	c.active_tab = 0
	c.prevent_header = true
    c.items = [:delivery_panel]# , { :title => "Fertigmeldungen" }]#, { :title => "Fakturierung" } ]
	super(c)
  end

end