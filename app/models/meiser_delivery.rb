class MeiserDelivery < ActiveRecord::Base
  attr_accessible :indate, :outdate, :remarks

  default_scope order("#{self.table_name}.created_at DESC")

  validates_presence_of :indate, :outdate
  validates_datetime :outdate, :after => :indate

  before_create :set_commission

  has_many :deliver_references, :dependent => :destroy, :foreign_key => "delivery_id"

  private

  def set_commission
   self.commission = self.commission = NextFreeNumber.generate("Meiser")
  end

end
