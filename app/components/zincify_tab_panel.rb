class ZincifyTabPanel < Netzke::Basepack::TabPanel

  component :delivery_panel do |c|
   c.title = I18n.t("activerecord.models.delivery")
   c.prevent_header = true
  end
  
  component :sort_list do |c|
   c.klass = Netzke::Basepack::Grid
   c.model = "SortList"
   c.rows_per_page = 100
   c.force_fit = true
   c.prevent_header = true
   c.enable_column_filters = false
   c.enable_edit_in_form = false
   c.title = I18n.t("activerecord.models.sort_list")
   c.columns = [
		{
			:name => :id,
			:read_only => true
		},
		{
			:name => :number,
			:width => 200
		},
		{
			:name => :description,
			:width => 400,
		},
		{
			:name => :ranking,
			:width => 200,
		},
		{
			:name => :created_at,
			:width => 200,
			:read_only => true
		},
		{
			:name => :updated_at,
			:width => 200,
			:read_only => true
		},
	]
  end
  
  component :weighting_list do |c|
     c.title = I18n.t("activerecord.models.weighting_list")
	 c.prevent_header = true
  end
  
  component :article_grid do |c|
     #c.title = "Stammdaten Artikel"
	 c.title = I18n.t("activerecord.models.item_base_data")
	 c.prevent_header = true
  end
  
  def configure(c)
  	c.active_tab = 0
	c.prevent_header = true
    c.items = [:delivery_panel,:sort_list,:weighting_list, :article_grid]
	super(c)
  end

end