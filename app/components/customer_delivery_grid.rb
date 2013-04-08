class CustomerDeliveryGrid < DeliveryGrid

  component :add_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.new_customer_delivery")
   c.form_config.items = [
		{
			:name => :customer__search_string,
			:scope => "bpid <> 280000001 and bpid <> 280000142"
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
	super - [:state, :reference, :cash_payer_name]
  end

end