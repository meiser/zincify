class Printer < ActiveRecord::Base

  include MeiserRails::Informix

  attr_accessible :description, :ident

  def self.synchronize_with_baan
   foreach_baan("select t_drbez, t_drcd from twhmei005120") do |pr|
    lp = Printer.find_or_initialize_by_ident(pr["t_drcd"].strip)
    lp.description = pr["t_drbez"].strip
    lp.save
   end
  end

end

