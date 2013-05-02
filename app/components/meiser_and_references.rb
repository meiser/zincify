class MeiserAndReferences < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence

  def configure(c)
    super
    c.items = [
      { netzke_component: :meiser_deliveries, region: :center },
      #{ netzke_component: :boss_details, region: :east, width: 240, split: true },
      { netzke_component: :references, region: :south, height: 250, split: true }
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false

    # Overriding initComponent
    c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		
        // setting the 'rowclick' event
        var view = this.getComponent('meiser_deliveries').getView();
		view.on('itemclick', function(view, record){
   		  // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
          this.selectMeiserDelivery({delivery_id: record.get('id')});
          this.getComponent('references').getStore().load();
          //this.getComponent('boss_details').updateStats();
        }, this);
		
		
	
		//console.log(this.getComponent('meiser_deliveries').getStore().getCount());
		//console.log(view.getStore().getAt(1));
		//console.log(view.getSelectionModel().getSelection());
		//,function(key,value){
		//}
		//view.on().selectFirstRow();
		//console.log(view);
		//view.selectFirstRow();
      }
    JS
  end

  endpoint :select_meiser_delivery do |params, this|
    # store selected boss id in the session for this component's instance
	p params[:delivery_id]
	component_session[:selected_meiser_delivery_id] = params[:delivery_id]
  end

  component :meiser_deliveries do |c|
   c.klass = MeiserDeliveryGrid
   c.model = "MeiserDelivery"
   c.title = I18n.t("netzke.titles.meiser_deliveries")
  end

  component :references do |c|
    c.klass = Netzke::Basepack::Grid
	c.model = "DeliverReference"
	c.title = I18n.t("netzke.titles.deliver_references")
    c.data_store = {auto_load: false}
    c.scope = {:delivery_id => component_session[:selected_meiser_delivery_id]}
    c.strong_default_attrs = {:delivery_id => component_session[:selected_meiser_delivery_id]}
	
	c.columns = [
		{
			:name => :name,
			:width => 400,
			:read_only => false,
			:filterable => false,
			:sortable => false,
		},
		{
			:name => :created_at,
			:width => 100,
			:filterable => false,
			:sortable => false,
			:read_only => true
		},
		{
			:name => :updated_at,
			:width => 100,
			:filterable => false,
			:sortable => false,
			:read_only => true
		}
	]
	c.enable_column_filters = false
	c.enable_edit_in_form = false
	c.enable_edit_inline = true
	c.enable_extended_search  = false
	c.force_fit = true
  end
end