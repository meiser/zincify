class BundleDataJob < Struct.new(:delivery_number)

  def perform

    Printer.create(:ident =>"0815",:description => "skeller")



  end


end

