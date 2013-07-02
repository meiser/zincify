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
    c.border = false

    # Overriding initComponent
    c.init_component = <<-JS
      function(){
        // calling superclass's initComponent
        this.callParent();
		// setting the 'rowclick' event
        
		md = this.getComponent('meiser_deliveries');
		mr = this.getComponent('meiser_references');
		
		console.log(md.store);
		md.getStore().on('del', function(self, records, successful, operation, eOpts){
			if ((records) && (records.length > 0)) {
				this.getSelectionModel().select(0);
			}
		}, this);
		
		console.log(md);
		md.on("deleted", function(view, record){
			//alert("delete");
			//mr.getView().refresh();
			//console.log(this);//mr.refresh();
		}, this);
		
		md.on('itemclick', function(view, record){
			this.getComponent('meiser_references').setDisabled(true);
			this.selectMeiserDelivery({delivery_id: record.get('id')});
			this.getComponent('meiser_references').getStore().load();
			this.getComponent('meiser_references').setDisabled(false);
		}, this);
		
		md.on('focus', function(view, record){
			this.getComponent('meiser_references').setDisabled(true);
			this.selectMeiserDelivery({delivery_id: record.get('id')});
			this.getComponent('meiser_references').getStore().load();
			this.getComponent('meiser_references').setDisabled(false);
		}, this);
		
		//var meiRef = this.getComponent('meiser_references').getView();
		//console.log(view.store);
		//view.store.on("refresh",function(){
		//	alert("Test");
		//	//this.selectMeiserDelivery({delivery_id: ""});
		//	this.getComponent('meiser_references').setTitle("Lieferscheine");
		//	//this.getComponent('meiser_references').setDisabled(true);
		//	
		//	meiRef.getStore().reload();
		//},this);
		
		//
		//});
		//console.log(view);
		//view.on('itemclick', function(view, record){
		  // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
        //  this.selectMeiserDelivery({delivery_id: record.get('id')});
          //console.log(this.getComponent('meiser_references'));
		//  this.getComponent('meiser_references').getStore().load();
		//  this.getComponent('meiser_references').setTitle("Lieferscheine für Kommission "+record.data.tag);
		//  this.getComponent('meiser_references').setDisabled(false);
          //this.getComponent('boss_details').updateStats();
		  //if (this.getComponent('meiser_deliveries').getStore().getCount() == 0){
		//	this.getComponent('meiser_references').setDisabled(false);
		 // };
        //}, this);
	
		//console.log(this.getComponent('meiser_deliveries').getStore().getCount());
		//console.log(view.getStore().getAt(1));
		//console.log(view.getSelectionModel().getSelection());
		//,function(key,value){
		//}
		//view.selectFirstRow();
		//console.log(view);
		//view.selectFirstRow();
      }
    JS
  end

  endpoint :select_meiser_delivery do |params, this|
    # store selected boss id in the session for this component's instance
	component_session[:selected_meiser_delivery_id] = params[:delivery_id]
  end

  component :meiser_deliveries do |c|
   c.klass = MeiserDeliveryGrid
   c.model = "MeiserDelivery"
   c.title = I18n.t("netzke.titles.meiser_deliveries")
   c.tbar = [:add, :del, :edit]
   c.bbar = []
   c.remember_selection_available = false
  end

  component :meiser_references do |c|
    c.klass = Netzke::Basepack::Grid
	c.model = "DeliverReference"
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