class WeightingListPrintDialog < Netzke::Basepack::Window
  def configure(c)
    super
    c.persistence = true
    c.title = "Tagesliste drucken"
    c.width = 800
    c.height = 500
    c.items = [:weighting_list]
  end

  component :weighting_list
end