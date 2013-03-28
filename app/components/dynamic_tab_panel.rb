class DynamicTabPanel < Netzke::Basepack::TabPanel

  #component :customer_grid do |c|
#	c.klass = BaanGrid
#	c.model = "Customer"
#	c.title = I18n.t("activerecord.models.customer")
#  end
  
#  component :cash_payer_grid do |c|
#	c.klass = BaanGrid
#	c.model = "CashPayer"
#	c.title = I18n.t("activerecord.models.cash_payer")
 # end
  #
#  component :delivery_grid do |c|
#	c.klass = BaanGrid
#	c.model = "Delivery"
#	c.title = I18n.t("activerecord.models.delivery")
#  end

  def configure(c)
    c.active_tab = 0
    c.prevent_header = true
    c.items = [ { :title => "I'm just a simple Ext.Panel" } ]
    super
  end
end