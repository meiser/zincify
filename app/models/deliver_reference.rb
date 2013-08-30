class DeliverReference < ActiveRecord::Base
  attr_accessible :name, :delivery_id

  validates_uniqueness_of :name, :case_sensitive => true, :if => Proc.new{|dr| dr.name != "ScannerWA"}
  
  validates :name, :presence => true
  validates_length_of :name, :minimum => 9, :maximum => 9
  
  has_many :meiser_bundle_tags, :dependent => :destroy
  
  belongs_to :meiser_delivery, :foreign_key => 'delivery_id'
  
end

