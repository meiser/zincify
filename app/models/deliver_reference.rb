class DeliverReference < ActiveRecord::Base
  attr_accessible :name, :delivery_id

  belongs_to :meiser_delivery

  #serialize :content, OpenStruct

  validates_uniqueness_of :name, :case_sensitive => true#, :scope => :delivery_id
  
  validates :name, :presence => true
  
  
end

