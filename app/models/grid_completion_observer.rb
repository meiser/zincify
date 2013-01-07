class GridCompletionObserver < ActiveRecord::Observer
 observe :completion
 
 def after_save(record)
  begin
    # only writing to Baan for grids (category 1)
	if record.sort_list.number == 1
		Delayed::Job.enqueue BaanCompletionJob.new(record.ref, record.weight_netto, record.created_at, record.user.login)
		record.logger.info("Completion #{record.ref} (#{record.id}) send to Delayed Job")
	end
  rescue
    record.logger.error("Completion #{record.ref} (#{record.id}) can't be send to Delayed Job")
  end
 end

end