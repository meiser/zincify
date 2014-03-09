class WindowWithSettings < Netzke::Basepack::Window

#  js_configure do |c|
   #c.init_component = <<-JS
   #   function(){
   #     // Call parent
#		this.callParent();
#		this.show();
#      }
#    JS
#  end

  def configure(c)
    c.persistence = false
    c.items = [:weighting_form]
	#c.items = [:next_free_numbers]
    c.title = "Einstellungen"
    c.closable = true
  end

  component :weighting_form do |c|
	
  end
  
  component :next_free_numbers do |c|
  	c.klass = Netzke::Basepack::Grid
  	c.model = "NextFreeNumber"
  	c.title = "Belegnummernkreise"
  	c.force_fit = true
  	c.enable_column_filters = false
	c.enable_edit_in_form = false
	c.enable_edit_inline = true
  	c.columns = [
  		{
			:name => :name,
			:width => 200
		},
		{
			:name => :prefix,
			:width => 100
		},
		{
			:name => :next_id,
			:width => 200,
			:read_only => true
		},
		{
			:name => :length,
			:width => 200
		},
		{
			:name => :year_prefix,
			:width => 100
		},
		{
			:name => :month_prefix,
			:width => 100
		},
		{
			:name => :day_prefix,
			:width => 100
		}


  	]
  end
end