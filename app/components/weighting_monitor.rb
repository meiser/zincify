class WeightingMonitor < Netzke::Base
  
  js_configure do |c|
    c.height = 400
	c.body_padding = 5
	c.layout = :border
	c.title = "Monitor Waage"
	c.init_component = <<-JS
		function(){
			this.callParent();
			this.scalePoll();
		}
	JS
	c.show_weight = <<-JS
		function(){
			comp = this;
			var task = new Ext.util.DelayedTask(function(){
				comp.scalePoll();
			});
			task.delay(4000);
	
		}
	
	JS
  end
  
  endpoint :server_update do |params, this|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel

    this[:update] = ["#{DateTime.now}"]
  end
  
  endpoint :scale_poll do |params, this|
   begin
	  scale=Rhewa82::Comfort.new("172.17.206.160",8000)
	  this[:update] = ["<h1 style='font-size: 2em; text-align:center; color: green;'>#{scale.brutto} #{scale.unit} ( Tara #{scale.tara} #{scale.unit})</h1>".strip]
	  this.show_weight
   rescue
	  this[:update] = ["<h1 style='font-size: 2em; text-align:center; color: red;'>Bitte Warten</h1>"]
	  this.show_weight
   ensure
	  this.show_weight
   end
  end

end