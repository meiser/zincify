class Application < Netzke::Basepack::Viewport
  include Netzke::Basepack::ItemPersistence

  HEADER_HTML = "Meiser Verzinkerei Plauen GmbH & Co. KG"

  js_configure do |c|
    c.layout = :border
    c.padding = 0
	c.mixin
  end

  def configure(c)
    c.items = [
		{
			region: :north,
			tbar: [
				{html: HEADER_HTML}, :about, :sign_out, :sign_in
			]
		},
		:zincify_tab_panel
	]
	super(c)
  end

  #
  # Component declarations
  #
  component :delivery_panel  
  component :zincify_tab_panel do |c|
   c.region = :center
  end
  
  
  
  action :about do |c|
    c.icon = :information
  end

  action :sign_in do |c|
    c.icon = :door_in
  end

  action :sign_out do |c|
    c.icon = :door_out
    #c.text = "Sign out #{current_user.email}" if current_user
  end
  
  
end