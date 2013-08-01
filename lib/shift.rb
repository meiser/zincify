class Shift

 attr_reader :date, :description, :start_time, :end_time 
 
 def self.now
  date = DateTime.now
  description = case date.hour
  	when 6..13 then 1
	when 14..21 then 2
	when 22..23 then 3
	when 0..5 then 3
  end
  new(description,date)
 end

 def initialize(shift, date)
  @date = date
  shift = shift.to_i.round
  @description = shift.between?(1,3) ? "#{shift}" : "1"
 
  case shift
  when 1
	@start_time = @date.change(:hour => 6)
	@end_time = @date.change(:hour => 13, :min => 59, :sec => 59)
  when 2
	@start_time = @date.change(:hour => 14)
	@end_time = @date.change(:hour => 21, :min => 59, :sec => 59)
  when 3
    case @date.hour
	when 22..23
		@start_time = @date.change(:hour => 22)
		@end_time = (@date+1.day).change(:hour => 5, :min => 59, :sec => 59)
 	when 0..5
		@start_time = (@date-1.day).change(:hour => 22)
		@end_time = @date.change(:hour => 5, :min => 59, :sec => 59)
	end
  end
 end
 
end
