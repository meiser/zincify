class Delivery < ActiveRecord::Base

  attr_accessible :customer_id, :indate,:outdate, :reference, :remarks

  belongs_to :customer

  before_create :set_commission
  before_create :set_indate


  validates_presence_of :customer, :outdate









  state_machine :initial => :captured do

    event :close do
     transition :captured => :closed
    end

  end





  private

  def set_commission
   self.commission = Random.rand(1000000000...9999999999)
  end

  def set_indate
    if self.indate.nil?
     self.indate=Time.now
    end
  end

end

