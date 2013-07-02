class MeiserBundleTag < ActiveRecord::Base
  attr_accessible :barcode, :deliver_reference
  
  belongs_to :deliver_reference
  
end
