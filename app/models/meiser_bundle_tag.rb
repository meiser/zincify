class MeiserBundleTag < ActiveRecord::Base
  attr_accessible :barcode, :deliver_reference
  
  validates_uniqueness_of :barcode, :case_sensitive => true
  
  belongs_to :deliver_reference
  
end
