class Delivery < ActiveRecord::Base
  
  attr_accessible :customer, :customer_id, :customer_bpid, :cash_payer, :cash_payer_id, :indate, :outdate, :reference, :remarks, :deliver_references_attributes

  attr_accessor :customer_bpid

  belongs_to :cash_payer
  belongs_to :customer

  default_scope order("indate DESC")
  
  #has_one :commission
  has_many :bookings
  has_many :deliver_references, :dependent => :destroy
  has_many :traverses, :through => :bookings

  accepts_nested_attributes_for :deliver_references, :allow_destroy => true, :reject_if => proc { |attributes| attributes['name'].blank? }

  before_create :set_commission
  
  #after_initialize :set_delivery_date

  validates :customer, :presence => true
  
  validates_presence_of :indate, :outdate
  
  validates_datetime :outdate, :after => :indate

  #validate :outdate_after_indate
  
  #validates :commission, :uniqueness => { :case_sensitive => false }
  
  #validate :validate_deliver_references
  
  #state_machine :initial => :captured do

  #  event :close do
  #   transition :captured => :closed
  #  end

  #end
  
  def full_name
   "(#{self.bpid}) #{self.name}"
  end
  
  def cash_payer?
   self.customer.bpid=="280000142" ? true : false
  end
  
 
  private
 
  def validate_deliver_references
   errors.add(:deliver_references, :at_least_one) if self.deliver_references.count >= 0
  end
  
  def set_delivery_date
   self.indate = Time.now.strftime("%d.%m.%Y")
   self.outdate = (self.indate+1.days).strftime("%d.%m.%Y")
  end
  
  def set_commission
   self.commission = SecureRandom.hex(10)
   self.commission = self.customer.bpid=="280000001" ? NextFreeNumber.generate("Meiser") : NextFreeNumber.generate("Meiser")
  end

  def set_indate
    if self.indate.nil?
     self.indate=Time.now
    end
  end

end

