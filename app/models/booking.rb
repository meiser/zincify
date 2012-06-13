class Booking < ActiveRecord::Base

  attr_accessible :deliver_id, :remarks, :pk, :traverse_id

  belongs_to :delivery
  belongs_to :traverse

end

