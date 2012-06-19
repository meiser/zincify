class DeliverReference < ActiveRecord::Base
  attr_accessible :name

  belongs_to :delivery

  serialize :content, OpenStruct

  validates :name, :uniqueness => {:case_sensitive => false, :scope => :delivery_id}



end

