class Weighting < ActiveRecord::Base
  attr_accessible :barcode, :ref, :pid, :shift, :sort_list_id, :weight_netto, :weight_brutto, :weight_tara, :scale_ident, :weight_unit
  
  belongs_to :sort_list
  
  validates :barcode, :presence => {:if => Proc.new { |w| w.ref.nil? }}#, :uniqueness => true
  validates :sort_list, :presence => true
  validates :weight_brutto, :numericality => {:greater_than => 0}
  validates :weight_tara, :numericality => {:within => 0..100}
  validates :weight_netto, :numericality => {:greater_than => 0}

  
  before_validation :set_weight_netto
  
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

end
