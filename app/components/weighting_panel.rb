class WeightingPanel < Application

  def configure(c)
    super(c)
    c.items = [
		{
			item_id: :main_panel,
			region: :north,
			tbar: [
				{html: HEADER_HTML}#, :about, :sign_out, :sign_in}
			]
		},
		{netzke_component: :weighting_form},
		{netzke_component: :weighting_monitor}
    ]
	  
  end
  
  component :weighting_form do |c|
   c.region = :center
  end
  
  component :weighting_monitor do |c|
   c.region = :south
   c.split = true 
  end  
  
end