class ArticleGrid < Netzke::Basepack::Grid

  js_configure do |c|
   c.on_sync_master_data = <<-JS
      function(a){
		var cmp = this;
		this.mask("Loading...");
		Rails.ItemBaseDataController.sync_master_data(function(r,e){
			cmp.unmask();
			if (r.success == true){
				cmp.store.reload();
				cmp.getView().refresh();
				Ext.Msg.show({
				  title: r.title,
				  width: 300,
				  msg: r.message,
				  buttons: Ext.Msg.OK,
				  icon: Ext.MessageBox.INFO
				});
				
			} else {
				alert(r.success);
			}
		});
      }
    JS
  end


  def configure(c)
   c.model = "ItemBaseData"
   c.rows_per_page = 100
   c.force_fit = true
   c.prevent_header = true
   c.enable_column_filters = true
   c.enable_edit = false
   c.enable_edit_in_form = false
   c.enable_extended_search = false
   c.edit_inline_available = false
   c.prohibit_delete = true
   c.prohibit_create = true
   c.prohibit_update = true
   c.filterable = false
   c.columns = [
		{
			:name => :item,
			:disabled => true,
			:read_only => true
		},
		{
			:name => :description,
			:disabled => true,
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
		}
   ]
   super
  end

  def default_bbar
	[:sync_master_data]
  end
  
  action :sync_master_data do |c|
    c.icon = :connect
	c.disabled = false
  end
  
end