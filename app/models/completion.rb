class Completion < ActiveRecord::Base
  attr_accessible :ref, :user_id, :sort_list_id, :sort_list, :weight_brutto, :weight_netto, :weight_tara

  has_one :sort_list

  belongs_to :user

  validates :ref, :presence => true, :uniqueness => true
  
  validates :weight_netto, :numericality => {:within => 0..2300}
  validates :weight_brutto, :numericality => {:within => 0..2300}
  validates :weight_tara, :numericality => {:within => 0..200}
  
end

