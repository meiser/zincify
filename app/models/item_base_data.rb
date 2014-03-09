class ItemBaseData < ActiveRecord::Base
  attr_accessible :description, :item
  
  validates_presence_of :item, :description
  
end
