class Delivery < ActiveRecord::Base
  attr_accessible :customer_id, :deadline, :reference

  belongs_to :customer
end

