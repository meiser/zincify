class PrintersController < ApplicationController

  respond_to :js



  def update
   begin
    Printer.delete_all if Printer.synchronizable?
    Printer.synchronize_with_baan
   end
  end


end

