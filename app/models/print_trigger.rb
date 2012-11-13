class PrintTrigger < ActiveRecord::Base
  attr_accessible :data, :label, :printed, :printer
end
