class Weighting < ActiveRecord::Base
  attr_accessible :barcode, :ref, :pid, :shift, :sort_list_id, :weight_netto, :weight_brutto, :weight_tara, :scale_ident, :weight_unit
  
  belongs_to :sort_list
  
  validates :barcode, :presence => {:if => Proc.new { |w| w.ref.nil? }}#, :uniqueness => true
  validates :sort_list, :presence => true
  validates :weight_brutto, :numericality => {:greater_than => 0}
  validates :weight_tara, :numericality => {:within => 0..100}
  validates :weight_netto, :numericality => {:greater_than => 0}
  validates :weight_unit, :presence => true
  validates :scale_ident, :presence => true
  validates :pid, :presence => true
  
  before_validation :set_weight_netto
  
  after_save :set_shift
  
  
  default_scope order("#{self.table_name}.created_at ASC")
  
  
  def set_weight_netto
   begin
	self.weight_netto = self.weight_brutto - self.weight_tara
   rescue
	self.weight_netto = 0
   end
  end
  
  def weight_brutto
   super.round
  end
  
  def weight_tara
   super.round
  end
  
  def weight_netto
   super.round
  end
  
  
  private

  def set_shift
   current_shift = case self.created_at.hour
	   when 6..13 then 1
	   when	14..21 then 2
	   when 22..23 then 3
	   when 0..5 then 3
   end
   
   self.update_column(:shift, current_shift)
   
  end
  
end
