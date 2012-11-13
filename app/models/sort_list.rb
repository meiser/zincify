class SortList < ActiveRecord::Base
  attr_accessible :description, :number
  
  validates :number,
	:presence => true,
	:uniqueness => true,
	:length => { :maximum => 10 },
	:numericality => {:greater_than => 0}

  validates :description, :presence => true
	
  def desc_with_number
   self.number.to_s+" "+self.description
  end  
   
   
   
end
