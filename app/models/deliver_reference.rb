class DeliverReference < ActiveRecord::Base
  attr_accessible :name

  belongs_to :delivery

  serialize :content, OpenStruct

  validates_uniqueness_of :name, :case_sensitive => true, :scope => :delivery_id
  
end

