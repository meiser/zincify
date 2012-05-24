class Commission < ActiveRecord::Base
  attr_accessible :appointment, :orno, :reference

  before_create :set_uuid, :set_date



  private

  def set_uuid
    self.orno = SecureRandom.random_number(100000)
  end

  def set_date
    if appointment.blank?
      self.appointment=Time.now
    end
  end

end

