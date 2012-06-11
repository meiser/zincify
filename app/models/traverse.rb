class Traverse < ActiveRecord::Base
  attr_accessible :name, :remarks

  attr_protected :state_event

  state_machine :initial => :unbooked do

    event :book_in do
     transition :unbooked => :booked
    end

    event :book_out do
      transition :booked => :unbooked
    end

    event :repair do
      transition [:booked, :unbooked] => :maintenance
    end

  end

end

