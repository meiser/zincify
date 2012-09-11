class Completion < ActiveRecord::Base
  attr_accessible :ref, :user_id, :weight


  belongs_to :user

  validates :ref, :presence => true, :uniqueness => true
  validates :weight, :numericality => {:within => 0..2300}


end

