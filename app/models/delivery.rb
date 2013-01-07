class Delivery < ActiveRecord::Base

  attr_accessible :customer, :customer_bpid, :cash_payer, :cash_payer_id, :indate, :outdate, :reference, :remarks, :deliver_references_attributes

  attr_accessor :customer_bpid


  belongs_to :cash_payer
  belongs_to :customer

  has_one :commission
  has_many :bookings
  has_many :deliver_references, :dependent => :destroy
  has_many :traverses, :through => :bookings

  accepts_nested_attributes_for :deliver_references, :allow_destroy => true, :reject_if => proc { |attributes| attributes['name'].blank? }

  before_create :set_commission
  

  
  #after_initialize :set_delivery_date

  validates_presence_of :customer, :indate, :outdate
  validate :outdate_bigger_than_indate
  
  
  #validate :validate_deliver_references
  
  #state_machine :initial => :captured do

  #  event :close do
  #   transition :captured => :closed
  #  end

  #end

  def cash_payer?
   self.customer.bpid=="280000142" ? true : false
  end
  
  private
 
  def outdate_bigger_than_indate
   if self.outdate < self.indate
    errors.add(:outdate, :outdate_bigger_than_indate)
   end
  end
 
  def validate_deliver_references
   errors.add(:deliver_references, :at_least_one) if self.deliver_references.count >= 0
  end
  
  def set_delivery_date
   self.indate = Time.now.strftime("%d.%m.%Y")
   self.outdate = (self.indate+1.days).strftime("%d.%m.%Y")
  end
  
  def set_commission
   #self.commission = Random.rand(1000000000...9999999999)
  end

  def set_indate
    if self.indate.nil?
     self.indate=Time.now
    end
  end

end

