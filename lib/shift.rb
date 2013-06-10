class Shift

 attr_reader :date, :description, :start_time, :end_time 
 
 def self.now
  @date = DateTime.now
  case @date.hour
		when 6..14
			@description = 1
			@start_time = @date.change(:hour => 6)
			@end_time = @date.change(:hour => 14)
		when 14..22
			@description = 2
			@start_time = @date.change(:hour => 14)
			@end_time = @date.change(:hour => 22)
		when 22..24
			@description = 3
			@start_time = @date.change(:hour => 22)
			@end_time = @date.change(:day =>@date.day.next, :hour => 6)
		when 0..6
			@description = 3
			@start_time = @date.change(:day =>(@date-1.day).day, :hour => 22)
			@end_time = @date.change(:hour => 6)
  end
  new(@description,DateTime.now)
 end

 def initialize(shift, date)
  @date = date.to_datetime
  shift = shift.to_i.round
  @description = shift.round.between?(1,3) ? "#{shift}" : "1"
  
  
  case shift
  when 1
	@start_time = @date.change(:hour => 6)
	@end_time = @date.change(:hour => 14)
  when 2
	@start_time = @date.change(:hour => 14)
	@end_time = @date.change(:hour => 22)
  when 3
    @start_time = @date.change(:hour => 22)
	@end_time = @date.change(:day =>(@date+1.day).day, :hour => 6)
  end
  
  @date = @date.utc
  @start_time = @start_time.utc
  @end_time = @end_time.utc
 end
 
end