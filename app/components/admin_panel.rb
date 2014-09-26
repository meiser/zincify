class AdminPanel < Netzke::Basepack::TabPanel
  include Netzke::Basepack::ItemPersistence

  component :next_free_numbers do |c|
	c.klass = Netzke::Basepack::Grid
	c.model = "NextFreeNumber"
	c.title = "Belegnummernkreise"
	c.prevent_header = true
  end
  
  component :printers do |c|
	c.klass = Netzke::Basepack::Grid
	c.model = "Printer"
	c.title = "Drucker"
	c.prevent_header = true
  end

  def configure(c)
  	c.active_tab = 0
	c.prevent_header = true
    c.items = [:printers,:next_free_numbers]
	c.force_fit = true
	super(c)
  end
  
  
end