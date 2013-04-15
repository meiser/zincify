class CustomerDelivery < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :customer_id, :tag, :indate, :outdate, :remarks

  default_scope order("indate DESC")

  validates_presence_of :indate, :outdate
  validates_datetime :outdate, :after => :indate

  before_create :set_commission

  belongs_to :customer

  validates :customer, :presence => true
  validates :tag, :presence => true
  
  private

  def set_commission
   self.commission = NextFreeNumber.generate("Lohnkunden")#self.commission = SecureRandom.hex(10)#NextFreeNumber.generate("Meiser")
  end

end
