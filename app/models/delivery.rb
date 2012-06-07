class Delivery < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :customer_id, :indate,:outdate, :reference, :remarks

  belongs_to :customer

  before_create :set_commission
  before_create :set_indate



  #friendly_id :commission, :use => :slug

  validates_presence_of :customer, :outdate, :indate, :remarks

  private

  def set_commission
   p "kommission wurde genommen"
   self.commission = Random.rand(1000000000...9999999999)
  end

  def set_indate
    if self.indate.nil?
     self.indate=self.created_at
    end
  end
  #http://harvesthq.github.com/chosen/

end

