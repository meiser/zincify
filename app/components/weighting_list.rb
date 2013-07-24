class WeightingList < Netzke::Basepack::Grid

  js_configure do |c|
   c.on_print_card = <<-JS
      function(a){
		console.log(this);
		//c.netzkeLoadComponent("weighthing_form", {container: "application", callback: function(cmp) {
		//alert("geladen");
		//}, scope: this});
      }
    JS
  end


  def configure(c)
   c.model = "Weighting"
   c.scope = Proc.new {|rel| rel.unscoped.order("weightings.created_at DESC") }
   c.rows_per_page = 100
   c.force_fit = true
   c.prevent_header = true
   c.enable_column_filters = true
   c.enable_edit_in_form = false
   c.enable_extended_search = false
   c.edit_inline_available = false
   c.prohibit_delete = false
   c.prohibit_create = true
   c.prohibit_update = false
   c.filterable = false
   c.columns = [
		{
			:name => :shift,
			:width => 100,
			:disabled => true,
			:read_only => true
		},
		{
			:name => :barcode,
			:width => 200
		},
		{
			:name => :ref,
			:width => 200
		},
		{
			:name => :sort_list__search_string,
			:width => 200
		},
		{
			:name => :weight_brutto,
			:width => 200
		},
		{
			:name => :weight_tara,
			:width => 200
		},
		{
			:name => :weight_unit,
			:width => 200,
			:read_only => true
		},
		{
			:name => :created_at,
			:width => 200,
			:read_only => true
		},
		{
			:name => :updated_at,
			:width => 200,
			:disabled => true,
			:read_only => true
		},
		{
			:name => :scale_ident,
			:width => 150,
			:disabled => true,
			:read_only => true
		}
   ]
   super
  end

  def default_bbar
	[*super,"|", :print_card]
  end
  
  action :print_card do |c|
    c.icon = :printer
	c.disabled = false
	#this.netzkeLoadComponent('simple_component');
  end
  
end