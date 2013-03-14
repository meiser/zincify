class NextFreeNumber < ActiveRecord::Base
  attr_accessible :description, :no

  validates :no, :uniqueness => true
  
  serialize :content, OpenStruct
  
  def self.generate no
	self.transaction do
		nfn = self.where(:no => no).lock(true).first
		returned_fifo = nfn.fifo
		nfn.fifo +=1
		nfn.save
		return "%09d" % returned_fifo
	end
  end
  
  
end
