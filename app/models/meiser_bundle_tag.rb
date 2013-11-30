class MeiserBundleTag < ActiveRecord::Base
  attr_accessible :barcode, :deliver_reference

  validates :barcode, :presence => true, :uniqueness => {:case_sensitive => true}
 
  belongs_to :deliver_reference
  
  has_many :weightings, :primary_key => :barcode, :foreign_key => :barcode
  
end
