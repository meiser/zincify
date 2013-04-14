class MeiserDelivery < ActiveRecord::Base
  attr_accessible :indate, :outdate, :remarks

  default_scope order("indate DESC")

  validates_presence_of :indate, :outdate
  validates_datetime :outdate, :after => :indate

  before_create :set_commission


  private

  def set_commission
   self.commission = self.commission = SecureRandom.hex(10)#NextFreeNumber.generate("Meiser")
  end

end
