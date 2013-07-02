class DeliverReference < ActiveRecord::Base
  attr_accessible :name, :delivery_id

  validates_uniqueness_of :name, :case_sensitive => true
  
  validates :name, :presence => true
  
  has_many :meiser_bundle_tags, :dependent => :destroy
  
end

