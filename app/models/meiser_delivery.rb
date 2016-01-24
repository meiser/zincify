class MeiserDelivery < ActiveRecord::Base
  attr_accessible :tag, :indate, :outdate, :remarks

  default_scope {order("#{self.table_name}.created_at DESC")}

  validate :regular_tag
  
  validates_length_of :tag, :minimum => 5, :maximum => 5
  validates_presence_of :tag, :indate, :outdate
  validates_datetime :outdate, :after => :indate
 #^([3][0-1]\d{3}|30000{0}|31000{0})$
  before_create :set_commission

  has_many :deliver_references, :dependent => :destroy, :foreign_key => "delivery_id"

  private

  def set_commission
   self.commission = self.commission = NextFreeNumber.generate("Meiser")
  end

  def regular_tag
   errors.add(:tag, :wrong_range) unless self.tag.to_i.between?(30001, 30999) or self.tag.to_i.between?(31001,31999)
  end
  
end
