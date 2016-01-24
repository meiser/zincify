class CashPayerDelivery < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :cash_payer_id, :custom_name, :tag, :indate, :outdate, :remarks

  default_scope {order ("#{self.table_name}.created_at DESC")}

  validates_presence_of :indate, :outdate
  validates_datetime :outdate, :after => :indate

  before_create :set_commission
  before_save :set_cash_payer

  belongs_to :cash_payer

  validates :cash_payer, :presence => true, :if => Proc.new{|r| r.custom_name.blank? }
  #validates :custom_name, :presence => true, :if => Proc.new{|r| r.cash_payer.addresscode == '280800004' }
  validates :tag, :presence => true
  
  
  private

  def set_commission
   self.commission = NextFreeNumber.generate("Barzahler")#self.commission = SecureRandom.hex(10)#NextFreeNumber.generate("Meiser")
  end
  
  
  def set_cash_payer
   if self.custom_name.present?
    self.cash_payer = CashPayer.where(:addresscode => "280800004").first
   end
  end

end
