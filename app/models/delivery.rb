class Delivery < ActiveRecord::Base
  attr_accessible :customer_id, :deadline, :reference

  has_one :customer
end

