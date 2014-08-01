class WeightingSelectForm < Netzke::Basepack::Form

  js_configure do |c|
	c.on_open_html = <<-JS
      function(){
		var shift = this.getForm().findField("shift");
		var shift_date = this.getForm().findField("shift_date");
		
		if (shift_date.isValid(false) && shift.isValid(false)){
			dateObj = shift_date.getValue();
			window.open("waage/"+ dateObj.getFullYear()+"/"+ (dateObj.getMonth()+1) +"/"+(dateObj.getDate())+"/"+shift.getValue()+".html" ,'_blank');	
		}
      }
    JS
	
	c.on_open_pdf = <<-JS
      function(form){
		var shift = this.getForm().findField("shift");
		var shift_date = this.getForm().findField("shift_date");
		
		if (shift_date.isValid(false) && shift.isValid(false)){
			dateObj = shift_date.getValue();
			window.open("waage/"+ dateObj.getFullYear()+"/"+ (dateObj.getMonth()+1) +"/"+(dateObj.getDate())+"/"+shift.getValue()+".pdf" ,'_blank');	
		}
	  }
    JS
	
	c.on_open_excel = <<-JS
      function(){
		alert("Excel");	
      }
    JS
	
  end

  def configure(c)
	c.width = 450
	c.height = 150
	c.items= [
		{ 
			field_label: "Schicht",
			name: "shift",
			xtype: :combo,
			editable: false,
			value: 1,
			store: [[1,"Schicht 1 (6:00 - 14.00 Uhr)"],[2,"Schicht 2 (14:00 - 22.00 Uhr)"], [3,"Schicht 3 (22:00 - 6.00 Uhr)"]]	
		},
		{
			field_label: "Datum",
			name: "shift_date",
			xtype: :datefield,
			value: I18n.l(DateTime.now-1.day, :format => :short),
		}
	]
	
	c.bbar = [:open_html, :open_pdf]
	
  	super(c)
  end
  
  action :open_html do |c|
    c.icon = :html
  end
  
  action :open_pdf do |c|
    c.icon = :page_white_acrobat
  end
 
  action :open_excel do |c|
    c.icon = :page_white_excel
  end
      
end