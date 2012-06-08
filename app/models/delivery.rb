class Delivery < ActiveRecord::Base

  attr_accessible :customer_id, :indate,:outdate, :reference, :remarks

  belongs_to :customer

  before_create :set_commission
  before_create :set_indate


  validates_presence_of :customer, :outdate

  private

  def set_commission
   p "kommission wurde genommen"
   self.commission = Random.rand(1000000000...9999999999)
  end

  def set_indate
    p "set_indate"
    if self.indate.nil?
     self.indate=Time.now
    end
  end

end

