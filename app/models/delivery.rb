class Delivery < ActiveRecord::Base
  extend FriendlyId

  attr_accessible :customer_id, :indate,:outdate, :reference, :remarks

  belongs_to :customer

  before_create :set_commission
  after_create :set_indate


  friendly_id :commission, :use => :slugged

  validates_presence_of :customer, :outdate

  private

  def set_commission
   self.commission = Random.rand(1000000000...9999999999)
  end

  def set_indate
    if self.indate.nil?
     self.indate=self.created_at
     self.save
    end
  end

end

