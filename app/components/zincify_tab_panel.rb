class ZincifyTabPanel < Netzke::Basepack::TabPanel

  component :delivery_panel do |c|
   c.title = I18n.t("activerecord.models.delivery")
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
			:name => :number,
			:width => 200
		},
		{
			:name => :description,
			:width => 400,
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
  
  def configure(c)
  	c.active_tab = 0
	c.prevent_header = true
    c.items = [:delivery_panel,:sort_list]
	super(c)
  end

end