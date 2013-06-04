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
		{component: :weighting_form}
    #{
    #  region: :south,
    #  bbar: [
    #    :settings
    #  ]
    #}
    ]
	  
  end
  
  component :weighting_form do |c|
   c.region = :center
  end
  
end