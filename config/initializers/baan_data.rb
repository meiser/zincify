begin
 BAAN_ORACLE = OCI8.new(ENV["ORACLE_USER"], ENV["ORACLE_PASSWORD"], ENV["ORACLE_URL"])
rescue Exception => e

 #Rails.logger.error e.message
 p e.message
 p e.backtrace
 #exit
end

