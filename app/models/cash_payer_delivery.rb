class CashPayerDelivery < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :cash_payer_id, :indate, :outdate, :remarks

  default_scope order("indate DESC")

  validates_presence_of :indate, :outdate
  validates_datetime :outdate, :after => :indate

  before_create :set_commission

  belongs_to :cash_payer

  validates :cash_payer, :presence => true


  private

  def set_commission
   self.commission = self.commission = SecureRandom.hex(10)#NextFreeNumber.generate("Meiser")
  end

end
