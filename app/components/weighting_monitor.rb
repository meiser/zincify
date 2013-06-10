class WeightingMonitor < Netzke::Base
  
  js_configure do |c|
    c.height = 400
	c.body_padding = 5
	c.layout = :border
	c.title = "Tagesleistung"
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
			task.delay(30000);
	
		}
	
	JS
  end
  
  endpoint :server_update do |params, this|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel

    this[:update] = ["#{DateTime.now}"]
	
  end
  
  endpoint :scale_poll do |params, this|
   begin
	  current_shift = Shift.now
	  
	  @weightings = Weighting.where("sort_list_id <>36").where(:created_at => current_shift.start_time..current_shift.end_time)
	  @sum = @weightings.sum(:weight_netto)
	  if @weightings.present?
		this[:update] = ["<h1 style='font-size: 2em; text-align:center; color: green;'>#{@weightings.length} Verwiegung(en), #{@sum} #{@weightings.first.weight_unit}</h1>"]
	  else
		this[:update] = ["<h1 style='font-size: 2em; text-align:center; color: green;'>In der aktuellen Schicht wurden noch keine Verwiegungen durchgeführt.</h1>"]
	  end
	  this.set_title "Tagesleistung Schicht #{current_shift.description}"
	  this.show_weight
   rescue
	  this[:update] = ["<h1 style='font-size: 2em; text-align:center; color: red;'>Bitte Warten ...</h1>"]
	  this.show_weight
   ensure
	  this.show_weight
   end
  end

end