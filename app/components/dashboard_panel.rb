class DashboardPanel < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence

  def configure(c)
    super
	c.title = "Dashboard"
    #c.items = [
    #  { netzke_component: :bosses, region: :center },
    #  { netzke_component: :boss_details, region: :east, width: 240, split: true },
    #  { netzke_component: :clerks, region: :south, height: 250, split: true }
    #]
  end
  
end