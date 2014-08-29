class BillForm < Netzke::Basepack::Form

  js_configure do |c|
	c.on_open_html = <<-JS
      function(){
		var delivery_date = this.getForm().findField("delivery_date");
		
		if (delivery_date.isValid(false)){
			dateObj = delivery_date.getValue();
			window.open("abrechnung/"+ dateObj.getFullYear()+"/"+ (dateObj.getMonth()+1) +"/"+(dateObj.getDate()) ,'_blank');	
		}
      }
    JS
	
	c.on_open_pdf = <<-JS
      function(){
		var delivery_date = this.getForm().findField("delivery_date");
		
		if (delivery_date.isValid(false)){
			dateObj = delivery_date.getValue();
			window.open("abrechnung/"+ dateObj.getFullYear()+"/"+ (dateObj.getMonth()+1) +"/"+(dateObj.getDate())+".pdf" ,'_blank');	
		}
      }
    JS
	

  end

  def configure(c)
	c.width = 450
	c.height = 150
	c.items= [
		{
			field_label: "Datum Anlieferung(en)",
			name: "delivery_date",
			xtype: :datefield,
			value: I18n.l(DateTime.now-1.day, :format => :short),
		}
	]
	
	c.bbar = [:open_pdf]
	
  	super(c)
  end
  
  action :open_html do |c|
    c.icon = :html
  end
  
  action :open_pdf do |c|
    c.icon = :page_white_acrobat
  end

      
end