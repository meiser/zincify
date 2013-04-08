class MeiserDeliveryGrid < DeliveryGrid

  component :add_window do |c|
   super(c)
   c.title = I18n.t("netzke.titles.new_meiser_delivery")
   d=Delivery.new
   #d.customer = Customer.where(:bpid => 280000001)
   #d.customer_id = 1
   c.form_config.record = d
   c.form_config.items = [
		#{
		#	:name => :customer__name,
		#	:scope => lambda{|r| r.where(:bpid => 280000001)}
		#},
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
			:name => :customer__name,
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