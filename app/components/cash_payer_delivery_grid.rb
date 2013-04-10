class CashPayerDeliveryGrid < DeliveryGrid


  def configure(c)
	c.columns = [
		{
			:name => :commission,
			:width => 200,
			:read_only => true,
			:filterable => false,
			:sortable => false,
		},
		{
			:name => :customer__bpid,
			:read_only => true,
			:filterable => false,
			:sortable => false,
			:width => 50
		},
		{
			:name => :customer__search_string,
			:width => 200,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :cash_payer__search_string,
			:width => 200,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :indate,
			:width => 100,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :outdate,
			:width => 100,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :remarks,
			:width => 300,
			:filterable => false,
			:sortable => false,
			:getter => lambda{|r| CGI::escapeHTML(r.remarks)}
		},
		{
			:name => :created_at,
			:width => 200,
			:filterable => false,
			:sortable => false
		},
		{
			:name => :updated_at,
			:width => 200,
			:filterable => false,
			:sortable => false
		}
	]
	super(c)
  end
  
  component :add_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.new_cash_payer_delivery")
   c.form_config.items = [
		#{
		#	:name => :customer__search_string,
		#	:scope => "bpid = 280000142"
		#},
		{
			:name => :cash_payer__search_string,
			:width => 300
		},
		{
			:name => :indate,
			:width => 100,
			:getter => lambda{|r| I18n.l(DateTime.now, :format => :short)}
		},
		{
			:name => :outdate,
			:width => 100,
			:getter => lambda{|r| I18n.l(DateTime.now+1.day, :format => :short)}

		},
		{
			:name => :remarks,
			:width => 100
		}
   ]
  end
  
  component :edit_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.edit_delivery")
   c.form_config.items = [
		{
			:name => :commission,
			:disabled => true
		},
		{
			:name => :customer__search_string,
			:disabled => true
		},
		{
			:name => :cash_payer__name,
			:disabled => true
		},
		{
			:name => :cash_payer__address,
			:disabled => true
		},
		{
			:name => :indate,
			:width => 100,
			:getter => lambda{|r| r.indate.strftime("%d.%m.%Y")}# I18n.l(r.indate, :format => :short)}
		},
		{
			:name => :outdate,
			:width => 100,
			:getter => lambda{|r| r.outdate.strftime(I18n.t("time.formats.short"))}
		},
		{
			:name => :remarks,
			:width => 100
		}
   ]
  end

  def columns
	[
		:commission,
		:customer__bpid,
		:customer__search_string,
		:cash_payer__search_string,
		:indate,
		:outdate,
		:created_at,
		:updated_at	
	]
  end
  
end