class MeiserAndReferences < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence

  def configure(c)
    super
    c.items = [
      { netzke_component: :meiser_deliveries, region: :center },
      #{ netzke_component: :boss_details, region: :east, width: 240, split: true },
      { netzke_component: :meiser_references, region: :south, height: 250}
    ]
  end

  js_configure do |c|
    c.layout = :border
    #c.border = false
    c.update_references = <<-JS
		function(my_title, enable){
			this.getComponent('meiser_references').setTitle(my_title);
			this.getComponent('meiser_references').getStore().load();
			this.getComponent('meiser_references').setDisabled(enable);
		}
	JS
    # Overriding initComponent
    c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		var view = this.getComponent('meiser_deliveries').getView();
		
		mdstore = view.getStore();
		
		mdstore.on('refresh',function(store){
			if (store.data.length != 0){
				this.getComponent('meiser_references').setDisabled(true);
				this.selectMeiserDelivery({delivery_id: store.data.items[0].get('id')});
				this.getComponent('meiser_references').setDisabled(false);
				this.getComponent('meiser_deliveries').getSelectionModel().select(0);
			} else {
				this.clearMeiserReference();
				this.getComponent('meiser_references').setDisabled(true);
			}
		},this);
		
        view.on('itemclick', function(view, record){
          // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
		  this.getComponent('meiser_references').setDisabled(true);
		  this.selectMeiserDelivery({delivery_id: record.get('id')});
        }, this);
	
      }
    JS
  end
  
  endpoint :select_meiser_delivery do |params,this|
	component_session[:selected_meiser_delivery_id] = params[:delivery_id]
	@meiser_delivery = MeiserDelivery.find(params[:delivery_id])
	this.update_references "Lieferscheine für Kommission #{@meiser_delivery.tag}"
  end
  
  endpoint :clear_meiser_reference do |params, this|
	component_session[:selected_meiser_delivery_id] = nil
	this.update_references "Lieferscheine", true
  end
  
  endpoint :meiser_delivery do |params, this|
	
  end
  
  component :meiser_deliveries do |c|
   c.klass = MeiserDeliveryGrid
   c.model = "MeiserDelivery"
   c.title = I18n.t("netzke.titles.meiser_deliveries")
   c.tbar = [:add, :del, :edit]
   c.bbar = []
   #c.remember_selection_available = false
  end

  component :meiser_references do |c|
	c.klass = Netzke::Basepack::Grid
	c.model = "DeliverReference"
	c.eager_loading = true
	#c.data_store = {auto_load: false}
	c.title = I18n.t("netzke.titles.deliver_references")
    c.scope = {:delivery_id => component_session[:selected_meiser_delivery_id]}
    c.strong_default_attrs = {:delivery_id => component_session[:selected_meiser_delivery_id]}
	c.columns = [
		{
			:name => :name,
			:width => 400,
			:read_only => false
		},
		{
			:name => :created_at,
			:width => 100,
			:read_only => true
		},
		{
			:name => :updated_at,
			:width => 100,
			:read_only => true
		}
	]
	c.enable_column_filters = false
	c.enable_edit_in_form = false
	c.enable_edit_inline = true
	c.enable_extended_search  = false
	c.force_fit = true
	c.disabled = true
  end
end