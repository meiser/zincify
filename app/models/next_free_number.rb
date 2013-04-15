class NextFreeNumber < ActiveRecord::Base
  attr_accessible :name, :description, :length, :prefix, :year_prefix, :month_prefix, :day_prefix

  #validates :fifo, :numericality => { :only_integer => true }
  
  before_save :set_number
  
  validates :length , :presence => true, :numericality => { :only_integer => true }
  validates :prefix, :presence => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  
  def self.generate name
	self.transaction do
		nfn = self.where(:name => name).lock(true).first
		returned_id = nfn.next_id
		nfn.next_id +=1
		nfn.save
		return "#{nfn.prefix}%0#{nfn.length-nfn.prefix.length}d" % returned_id
	end
  end
  
  private
  
  def set_number
	self.next_id = 1 unless self.next_id
  end
  
  
end
