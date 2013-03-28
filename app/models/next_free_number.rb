class NextFreeNumber < ActiveRecord::Base
  attr_accessible :name, :description, :fifo

  validates :name, :uniqueness => true
  #validates :fifo, :numericality => { :only_integer => true }
  
  serialize :content, OpenStruct
  
  before_save :set_number
  
  
  def self.generate name
	self.transaction do
		nfn = self.where(:name => name).lock(true).first
		returned_fifo = nfn.fifo
		nfn.fifo +=1
		nfn.save
		return "%09d" % returned_fifo
	end
  end
  
  private
  
  def set_number
	self.fifo = 0 unless self.fifo
  end
  
  
end
