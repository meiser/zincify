class StaticTabPanel < Netzke::Basepack::TabPanel
  
  component :baan_grid
  #component :baan_grid do |c|
  #  c.eager_loading = true
  #end

  def configure(c)
    c.active_tab = 0
    c.prevent_header = true
    c.items = [ { :title => "I'm just a simple Ext.Panel" }, :baan_grid, { :title => "I'm just a simple Ext.Panel 2"},{ :title => "I'm just a simple Ext.Panel 3"}]
    super
  end
end