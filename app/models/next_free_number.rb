class NextFreeNumber < ActiveRecord::Base
  attr_accessible :name, :description, :length, :prefix, :year_prefix, :month_prefix, :day_prefix

  validates :name, :uniqueness => true
  #validates :fifo, :numericality => { :only_integer => true }
  
  serialize :content, OpenStruct
  
  before_save :set_number
  
  
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
