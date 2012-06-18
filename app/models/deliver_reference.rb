class DeliverReference < ActiveRecord::Base
  attr_accessible :name

  belongs_to :delivery

  serialize :content, OpenStruct


end

