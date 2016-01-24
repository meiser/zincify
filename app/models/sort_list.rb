class SortList < ActiveRecord::Base
  attr_accessible :description, :number, :ranking
  
  has_many :weightings, :dependent => :restrict_with_error
  
  validates :number,
	:presence => true,
	:uniqueness => true,
	:length => { :maximum => 10 },
	:numericality => {:greater_than => 0}

  validates :description, :presence => true
  
  validates :ranking, :uniqueness => true
	
  def desc_with_number
   self.number.to_s+" "+self.description
  end  
   
  def search_string
  [self.number, self.description].join(" ")
  end
  
   
end
