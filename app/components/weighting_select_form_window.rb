class WeightingSelectFormWindow < Netzke::Basepack::Window

  def configure(c)
    c.persistence = false
    c.items = [:weighting_select_form]
    c.closable = true
	c.title = "Tagesliste Verwiegungen"
  end
  
  component :weighting_select_form
  
end