class BillFormWindow < Netzke::Basepack::Window

  def configure(c)
    c.persistence = false
    c.items = [:bill_form]
    c.closable = true
	c.title = "Abrechnung Anlieferungen"
  end
  
  component :bill_form
  
end